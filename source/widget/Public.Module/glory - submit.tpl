<!--
   晒成绩
    @require glory.less       
    @require glory.js       
-->
    <script type="text/javascript">
    function selectType3(s){
        var checkeds=$(s).find('option:checked');
        if(checkeds.val() !=''){
            var b = $('#type3 option:checked');
            $('#typeDesc').text(b.attr('description'));
            $('#goldTip').show();
        }else{
            $('#goldTip').hide();
        }
    }
    function selectType2(s){
        var checkeds=$(s).find('option:checked');
        var b = $('#type2 option:checked');
        if(checkeds.val() !='' && b.attr('show') == 1){
            $('#typeDesc').text(b.attr('description'));
            $('#goldTip').show();
        }else{
            $('#goldTip').hide();
        }
    }
    function selectType1(s){
        var checkeds=$(s).find('option:checked');
        var b = $('#type1 option:checked');
        if(checkeds.val() !='' && b.attr('show') == 1){
            $('#typeDesc').text(b.attr('description'));
            $('#goldTip').show();
        }else{
            $('#goldTip').hide();
        }
    }
    //验证提交参数
    function checkData(){
        var r = /^[0-9]*[1-9][0-9]*$/;
        //成绩类别
        var type1 = $('#type1').val();
        var type2 = $('#type2').val();
        var type3 = $('#type3').val();
        var b;
        //获取三级成绩类别中最后一个被选中的类别
        if (type1 && type1 != '') {
            b = $('#type1 option:checked');
        }
        if (type2 && type2 != '') {
            b = $('#type2 option:checked');
        }
        if (type3 && type3 != '') {
            b = $('#type3 option:checked');
        }
        if(r.test(type1) == false || b.attr('show') == 0) {
            alert('没有选择成绩类型哦');
            return false;
        }
        //年级
        var gradeId = $('#gradeId').val();
        if(r.test(gradeId) == false){
            alert('没有选择年级哦');
            return false;                   
        }
        //学科
        var subjectId = $('#subjectId').val();
        if(r.test(subjectId) == false){
            alert('没有选择学科哦');
            return false;                       
        }
        //验证老师
        var teacherIds = $('#teacherIds').val();
        if(teacherIds == ''){
            alert('勾选一下你的授课老师吧~');
            return false;
        }

        //验证上传图片
        var gloryImg = $('#gloryImg').val();
        if(gloryImg == ''){
            alert('无图无真相，上传一张你的成绩吧');
            return false;
        }

        //验证说两句
        var acceptanceSpeech = $('#acceptanceSpeech').val();
        if(acceptanceSpeech != ''){
            if(acceptanceSpeech.length >=140){
                alert('评论内容最多140字');
                return false;
            }
        }
        return true;
    }


    function getFullPath(obj){
        if(obj){
            if (window.navigator.userAgent.indexOf("MSIE")>=1){
                var imgs = $(' #big_pic_wrap');
                try{
                    imgs.each(function(){
                        var that = this,
                        id = that.id,
                        width = $(that).width(),
                        height= $(that).height();
                        $(that).find('span').empty();
                        var newPreview = document.getElementById(id);    
                        var imgDiv = document.createElement("div");
                        document.body.appendChild(imgDiv);
                        imgDiv.style.width = width + "px";    imgDiv.style.height = height + "px";
                        imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";   
                        imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = obj.value;

                        $(newPreview).find('span').append(imgDiv);    
                    });
                    $('.up_avatar_content').show();
                        }catch(e){      // ie禁用本地路径时
                            $('.up_avatar_content').hide();
                            var btn = $('#loadFile');
                            var filepath = $('.filespath');
                            if(filepath.length > 0){
                                filepath.html(btn.val());
                            }else{
                                btn.next('.btn_up').after('<span class="filespath">'+ btn.val() +'</span>');
                            }
                        }

                    }
             //firefox
             else {
                if(obj.files){
                    // 360下不支持window.URL
                    if(!window.URL){
                        var btn = $('#gloryImg');
                        var filepath = $('.filespath');
                        if(filepath.length > 0){
                            filepath.html(btn.val());
                        }else{
                            btn.next('.btn_up').after('<span class="filespath">'+ btn.val() +'</span>');
                        }

                    }else{
                        setImg(window.URL.createObjectURL(obj.files.item(0)));
                        return window.URL.createObjectURL(obj.files.item(0));                       
                    }
                }
                setImg(obj.value);
                return obj.value;
            }
            setImg(obj.value);
            return obj.value;
        }

        function setImg(url){
            var strSrc = $("#gloryImg").val();
            var pos = strSrc.lastIndexOf("."); 
            var lastname = strSrc.substring(pos, strSrc.length);
            if (lastname.toLowerCase() != ".jpg" && lastname.toLowerCase() != ".gif" && lastname.toLowerCase() != ".png" && lastname.toLowerCase() != ".jpeg") {  
                $('#gloryImg').val('');
                xue.alert("您选择的文件类型为" + lastname + "，图片必须为 JPG,GIF,PNG 类型");
                return false;  
            }
            $('#imgs, .big_pic img').attr('src',url);
        }
    }
    t_checked = [];
    $(function(){
        //var teacher_check = $('.teacherId');
        $('body').on('click','.teacherId', function(){
            var that = $(this);
            //console.log(that.prop('checked'));
            var _index = $.inArray(that.val(),t_checked);
            if(that.prop('checked')){
                if(_index == -1){
                    t_checked.push(that.val());
                }
            }else{
                if(_index > -1){
                    t_checked.splice(_index,1);
                }
            }
            $('#teacherIds').val(t_checked);
        });
    });
    </script>
</head>
<body>
    <!--content开始-->
    <div class="wrapper_body glory_body">
        <div class="log glory_log_submit">
            <div class="log_left register">
                <form class="form_glory" id="form_gloryId" action="/glorys/uploadGlory" enctype="multipart/form-data" method="POST" onsubmit ="return checkData();">
                    <div class="formLabel">
                        <label for=""> <i>*</i>
                            成绩类型：
                        </label>
                        <span id="glorys"></span>
                        <div class="tx_tips" id="goldTip" style="display: none">
                            <strong id="typeDesc"></strong>
                        </div>
                    </div>
                    <div class="formLabel">
                        <label for=""> <i>*</i>
                            选择年级：
                        </label>
                        <span>
                            <select  name="gradeId" id="gradeId" class="select_form">
                                <option value="">请选择&nbsp;</option>
                                <option value="1">幼升小</option>
                                <option value="2">一年级</option>
                                <option selected="true" value="3">二年级</option>
                                <option value="4">三年级</option>
                                <option value="5">四年级</option>
                                <option value="6">五年级</option>
                                <option value="7">六年级</option>
                                <option value="8">初一</option>
                                <option value="9">初二</option>
                                <option value="10">初三</option>
                                <option value="11">高一</option>
                                <option value="12">高二</option>
                                <option value="13">高三</option>
                                <option value="22">毕业</option>
                                <option value="23">0-4岁</option>
                            </select>
                        </span>
                    </div>
                    <div class="formLabel">
                        <label for=""> <i>*</i>
                            选择学科：
                        </label>
                        <span>
                            <select  name="subjectId" id="subjectId" class="select_form" onchange='subjectCourse(this.value)'>
                                <option value="">请选择&nbsp;</option>
                                <option value="100">综合</option>
                                <option value="1">语文</option>
                                <option value="2">数学</option>
                                <option value="3">英语</option>
                                <option value="4">物理</option>
                                <option value="5">化学</option>
                                <option value="6">生物</option>
                                <option value="19">讲座</option>
                                <option value="21">科学</option>
                            </select>
                        </span>
                    </div>

                    <div class="formLabel_teacher">
                        <label for="">
                            <i>*</i> 感谢老师：
                        </label>
                        <div id="noSubject"><div class="thank_teacher">选择学科后会出现对应的老师</div></div>
                        <div id="subTeacher"></div>
                    </div>
                    <div class="formFileUpPic">
                        <label for=""> <i>*</i>
                            晒成绩　：
                        </label>
                        <span class="file_up_pic">
                            <input type="file" onchange="getFullPath(this);" class="input_file" name="gloryImg" id="gloryImg" autocomplete="off">                           
                            <div class="btn_up"></div>
                        </span>
                        <span class="grey">仅支持JPG,GIF,PNG且文件小于5M</span>
                    </div>
                    <div class="up_avatar_con">
                        <div class="big_pic" id="big_pic_wrap">
                            <span class="up_avatar_pic"><img id="big_pic" src=""  alt="" width ="140" height="140"/></span>
                        </div>                          
                        <span class="up_avatar_info">
                            亲爱的学员：<br/>
                            如果你上传的是试卷卷头，请至少包含：科目名称+分数+姓名；<br/>
                            如果你上传的是成绩单，请至少包含：总分+排名+个人姓名；<br/>
                            如果你上传的是奖状，最好是你与奖状的合影！<br/>
                            谢谢亲的配合，各位老师们会尽快审核完毕滴！<br/>
                            <i style="color:red">上传违法、无关或伪造图片的后果是非常严重的，要谨慎哦！</i>
                        </span>
                    </div>
                    <input type="hidden" name="teacherIds" id="teacherIds" value="" autocomplete="off">

                    <div class="ui_comment formLabel_text">
                        <label for="">说两句：</label>
                        <span class="grey">最多可输入140个字</span>
                        <p class="comment_textarea text">
                            <textarea id="acceptanceSpeech" name="acceptanceSpeech"  placeholder ="独乐乐不如众乐乐，分享下你的学习经验吧！"></textarea>
                        </p>
                        <p class="info">分享自己的学习经验，有机会被老师推荐到首页哦</p>
                    </div>

                    <div class="formLabel_btn">
                        <span class="btn_wrap btn_wrap_orange">
                            <!--                                <span class="btn btn_submit" id="submit_verify">发布</span>-->
                            <input type="submit" class="btn btn_submit" value="发布">
                        </span>
                    </div>
                </form>
            </div>
            <div class="log_right enwidth">
                <div class="glory_from_pic">
                    <img src="http://img04.xesimg.com/glory/submit-img.png">
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="glory.js"></script>


</body>
<script type="text/javascript">
$(function () {
    //限制文本域字数显示
    $('.glory_log_submit').off('input keyup paste focus', '.comment_textarea textarea').on('input keyup paste focus', '.comment_textarea textarea', function(){
        // alert(111)
        var that = this;
        setTimeout(function(){
            glory.comment.textareaNum(that);
        }, 10);
    });
}); 
function subjectCourse(subjectId){
    $('#teacherIds').val('');
    t_checked = [];
    var te= /^[1-9]+[0-9]*]*$/;
    if (!te.test(subjectId)){ 
        $('#noSubject').show();
        $('#subTeacher').html('');
        return false;
    }else{          
        $('#teachers').show();
    }
    $.ajax({
        url : '/glorys/ajaxStuTeacher',
        data : 'subjectId='+subjectId,
        type: "POST",
        dataType: 'html',
        success: function(d){
            var msg = xue.ajaxCheck.HTML(d);
            if(msg){
                $('#noSubject').hide();
                $('#subTeacher').html(msg);
            }
        }
    });
}
$(function() {
        modules_params = {
            // 系统模块json文件url
            'jsonUrl': '/Glorys/getGloryTypeJson/',
            
            // 系统模块联动容器
            'container': 'span',
            // 系统模块联动容器id
            'container_id': 'glorys',
            
            // 一级系统模块标识
            'level_1_id': 'type1',
            // 一级系统模块默认值
            'level_1_default': '',
            
            // 二级系统模块标识
            'level_2_id': 'type2',
            // 二级系统模块默认值
            'level_2_default': '',
            
            // 三级系统模块标识
            'level_3_id': 'type3',
            // 三级系统模块默认值
            'level_3_default': ''
        };
        initSelects(modules_params);
    });

</script>

