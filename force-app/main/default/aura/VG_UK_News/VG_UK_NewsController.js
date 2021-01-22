({
    doInit : function(component, event, helper) {
        var ListNews=new Array();
        var ListNews2=new Array();
        var action = component.get("c.getNews");
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                ListNews=response.getReturnValue();
                component.set("v.news",ListNews);
                if(ListNews.length==0){
                    $("#s").html("Today have No News...");
                }else{
                    setListNews(ListNews);
                }
            }else{
                console.log('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
        function setListNews(news){
            ListNews2=news;
            var i=0;
            doSetTimeout(ListNews2,i);
            function doSetTimeout(ids,i) {
                var e=ids;
                var j=e.length;
                if(i===0){
                    $("#s").html("<a target='_blank' style=''  href='"+ids[i].url+"'><b>"+ ids[i].title+"</b></a><br><p style='margin-top:15px;'>"+ids[i].description+"</p>");
                    
                    $("#s1").html("<img id='i2' height='110px' src='"+ids[i].urlToImage+"'/>");
                    i++;
                    console.log("if1");
                    doSetTimeout(ids,i);
                }else if(i>0 && i<j){
                    console.log("if2");
                    write(i,e);
                }else if(i===j){
                    console.log("if3");
                    i=0;
                    doSetTimeout(e,i);
                }
                function write(i,ids){
                    setTimeout(function(){
                        $("#s").html("<a target='_blank' style=''  href='"+ids[i].url+"'><b>"+ ids[i].title+"</b></a><br><p style='margin-top:15px;'>"+ids[i].description+"</p>");
                        $("#s1").html("<img id='i2' height='110px' src='"+ids[i].urlToImage+"'/>");
                        i++;
                        console.log(i);
                        doSetTimeout(ids,i);
                    }, 7000);           
                }             
            }
        }
    }
})