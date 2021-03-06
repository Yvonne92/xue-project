<!--
    @require certificate.binding.less
    @require certificate.binding.js
-->

<div class="cb-content">
    <div class="binding-left">
        <p>将卡号和密码输入下方输入框内</p>
        <div>
            <label for="">卡号：</label>
            <input class="bindcardNo" type="text">
        </div>
        <div class="error-box">
            <span class="bindcardNo-warning error"></span>
        </div>

        <div>
            <label for="">密码：</label>
            <input class="bindcardPass" type="password">
        </div>
        <div class="error-box">
            <span class="bindcardPass-warning error"></span>
        </div>
        
        <span class="btn-bindcard btn btn-info">激活</span>
    </div>
</div>
<div class="prompt-box">
    <img class="prompt" src="img/prompt.png">
    <div class="cb-prompt-box">
        <h3>提示</h3>
        <p>如果您对激活课程绑定卡有任何疑问，请查看“帮助中心”或拨打：<strong>400-800-2211</strong></p>
    </div>
</div>
