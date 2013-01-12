/*JAVASCRIPT */
/*
jQuery delayed observer
(c) 2007 - Maxime Haineault (max@centdessin.com)
http://www.studio-cdd.com:8080/haineault/blog/17/
*/

jQuery.fn.extend({
    delayedObserver:function(delay, callback){
        $this = $(this);
        if (typeof window.delayedObserverStack == 'undefined') {
            window.delayedObserverStack = [];
        }
        if (typeof window.delayedObserverCallback == 'undefined') {
            window.delayedObserverCallback = function(stackPos) {
                observed = window.delayedObserverStack[stackPos];
                if (observed.timer) clearTimeout(observed.timer);
                
                observed.timer = setTimeout(function(){
                    observed.timer = null;
                    observed.callback(observed.obj.val(), observed.obj);
                }, observed.delay * 1000);

                observed.oldVal = observed.obj.val();
            }
        }
        window.delayedObserverStack.push({
            obj: $this, timer: null, delay: delay,
            oldVal: $this.val(), callback: callback });
            
            stackPos = window.delayedObserverStack.length-1;
        
        $this.keyup(function() {
            observed = window.delayedObserverStack[stackPos];
                if (observed.obj.val() == observed.obj.oldVal) return;
                else window.delayedObserverCallback(stackPos);
        });
    }
});
