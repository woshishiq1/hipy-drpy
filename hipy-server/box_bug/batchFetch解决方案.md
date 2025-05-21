### proxyMultiRequest.java

```java
 private Response proxyMultiRequest(JsonArray data) {
        try {
            Map<Integer, String> indexMap = new ConcurrentHashMap<>();
            CountDownLatch countDownLatch = new CountDownLatch(data.size());
            int maxThread = Math.min(data.size(), 16);
            ExecutorService threadPool = new ThreadPoolExecutor(maxThread, maxThread,
                    1L, TimeUnit.SECONDS, new LinkedBlockingDeque<>(4096));

            for (int i = 0; i < data.size(); i++) {
                JsonObject obj = (JsonObject) data.get(i);
                String url = obj.get("url").getAsString();
                JsonObject options = obj.get("options").getAsJsonObject();
                LOG.e(url);
                if (TextUtils.isEmpty(url)) {
                    countDownLatch.countDown();
                    continue;
                }
                int finalI = i;
                threadPool.execute(() -> {
                    long start = System.currentTimeMillis();
                    try {
                        Req req = Req.objectFrom(new Gson().toJson(options));
                        okhttp3.Response res = Connect.to(url, req).execute();
                        JsonObject headers = new JsonObject();
                        for (Map.Entry<String, List<String>> entry : res.headers().toMultimap().entrySet()) {
                            if (entry.getValue().size() == 1) headers.addProperty(entry.getKey(), entry.getValue().get(0));
                            if (entry.getValue().size() >= 2) headers.addProperty(entry.getKey(), String.join(";", entry.getValue()));
                        }

                        JsonObject jsonObject = new JsonObject();
                        jsonObject.addProperty("index", finalI +"");
                        jsonObject.addProperty("url", url);
                        jsonObject.addProperty("code", res.code());
                        jsonObject.add("headers", headers);

                        if (req.getBuffer() == 0) {
                            jsonObject.addProperty("content", new String(res.body().bytes(), req.getCharset()));
                        } else if (req.getBuffer() == 1) {
                            JsonArray array = new JsonArray();
                            for (byte aByte : res.body().bytes()) {
                                array.add((int) aByte);
                            }
                            jsonObject.add("content", array);
                        } else if (req.getBuffer() == 2) {
                            jsonObject.addProperty("content", Base64.encodeToString(res.body().bytes(), Base64.DEFAULT | Base64.NO_WRAP));
                        }
                        indexMap.put(finalI, jsonObject.get("content").getAsString());
                    } catch (IOException e) {
                        e.printStackTrace();
                    } finally {
                        countDownLatch.countDown();
                        LOG.e("js task end, used " + (System.currentTimeMillis() - start) + "毫秒");
                    }

                });
            }

            try {
                countDownLatch.await(data.size() / 16 * 10 + 10, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            try {
                if (!threadPool.isShutdown() && !threadPool.isTerminated()) {
                    threadPool.shutdown();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            String[] sdata = new String[data.size()];
            for (Map.Entry<Integer, String> entry : indexMap.entrySet()) {
                sdata[entry.getKey()] = entry.getValue();
            }
            LOG.e(new Gson().toJson(sdata));
            return newFixedLengthResponse(Response.Status.OK, NanoHTTPD.MIME_PLAINTEXT, new Gson().toJson(sdata));
        } catch (Throwable th) {
            return newFixedLengthResponse(Response.Status.OK, NanoHTTPD.MIME_PLAINTEXT, th.getMessage());
        }
    }

```

### 代理Post

```java
if (session.getMethod() == Method.POST){
            parse(session, files);
            String postData = files.get("postData");
            if(url.startsWith("/bf") && postData != null){
                LOG.e(postData);
                return proxyMultiRequest(JsonParser.parseString(postData).getAsJsonArray());
            }
        }
```

### js注入

```java
@Keep
@Function
public JSArray batchFetch(JSObject options){
    String json = OkHttp.stringPost("http://" + Util.getIp() + ":" + Proxy.getPort() + "/bf", ((JSArray) options).toJsonArray().toString());
    return (JSArray) ctx.parse(json);
}
```