<script type="text/javascript">
    (function() {
        // 匿名函数，防止污染全局变量
        var utterances = document.createElement('script');
        utterances.type = 'text/javascript';
        utterances.async = true;
        utterances.setAttribute('issue-term','{{ theme.utterance.issue-item }}')
        utterances.setAttribute('theme','{{ themm.utterance.theme }}')
        utterances.setAttribute('repo','{{ theme.utterance.repo }}')
        utterances.crossorigin = 'anonymous';
        utterances.src = 'https://utteranc.es/client.js';
        // content 是要插入评论的地方
        document.getElementById('gitment-container').appendChild(utterances);
    })();
</script>
