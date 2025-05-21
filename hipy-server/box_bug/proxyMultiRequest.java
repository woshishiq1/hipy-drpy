

    private Response proxyMultiRequest(JsonArray data) {
        try {
            List<JsonObject> list = new ArrayList<>();
            CountDownLatch countDownLatch = new CountDownLatch(data.size());
            ExecutorService threadPool = Executors.newCachedThreadPool();
            int page = 0;
            for (JsonElement item : data) {
                JsonObject obj = (JsonObject) item;
                final String finalUrl = obj.get("url").getAsString();
                final JsonObject finalOption = obj.get("data").getAsJsonObject();
                final String index = "" + page;
                threadPool.execute(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            Req req = Req.objectFrom(new Gson().toJson(finalOption));
                            okhttp3.Response res = Connect.to(finalUrl, req).execute();
                            JsonObject headers = new JsonObject();
                            for (Map.Entry<String, List<String>> entry : res.headers().toMultimap().entrySet()) {
                                if (entry.getValue().size() == 1) headers.addProperty(entry.getKey(), entry.getValue().get(0));
                                if (entry.getValue().size() >= 2) {
                                    JsonArray jsonArray = new JsonArray();
                                    for (String item : entry.getValue()){
                                        jsonArray.add(item);
                                    }
                                    headers.add(entry.getKey(), jsonArray);
                                }
                            }

                            JsonObject jsonObject = new JsonObject();
                            jsonObject.addProperty("index", index);
                            jsonObject.addProperty("url", finalUrl);
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
                            list.add(jsonObject);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        countDownLatch.countDown();
                    }
                });
                page++;
            }

            try {
                countDownLatch.await(15, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            threadPool.shutdownNow();

            Collections.sort(list, new Comparator<JsonObject>() {
                @Override
                public int compare(JsonObject o1, JsonObject o2) {
                    int n1 = o1.get("index").getAsInt();
                    int n2 = o2.get("index").getAsInt();
                    return Integer.compare(n1, n2);
                }
            });

            return newFixedLengthResponse(Status.OK, NanoHTTPD.MIME_PLAINTEXT, new Gson().toJson(list));
        } catch (Throwable th) {
            return newFixedLengthResponse(Status.OK, NanoHTTPD.MIME_PLAINTEXT, th.getMessage());
        }

    }