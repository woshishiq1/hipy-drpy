$(document).ready(function () {
 const markdownText = `

<details>
<summary>TVBox 自用接口</summary>

###### [频道](https://t.me/clun_tz) / [群组](https://t.me/clun_top) TVBox 自用接口 GitHub [链接](https://github.com/cluntop/cluntop.github.io)

\`自用
https://clun.top/box.json
\`

\`PG
https://clun.top/jsm.json
\`

\`饭总
https://clun.top/api.json
\`

</details>

`;

 document.getElementById('markdown').innerHTML = marked.parse(markdownText);
});
