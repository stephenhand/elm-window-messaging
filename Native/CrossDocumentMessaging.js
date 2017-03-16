/**
 * Created by stephen.hand on 09/03/2017.
 */

//extern F2

var _stephenhand$elm_window_messaging$Native_CrossDocumentMessaging = function(){
    if (!window || !window.postMessage){
        throw new Error("Cross document messaging not supported.")
    }

    function wrapWindow(nativeWindow){
        return {
            ctor:'_Site',
            open: function(url, name, specs){
                return wrapWindow(nativeWindow.open(url, name, specs))
            },
            close: function(){
                nativeWindow.close();
            },
            postMessage: function(message, targetOrigin, transfers){
                nativeWindow.postMessage(message, targetOrigin, transfers);
            },
            addMessageListener: function(listener){
                nativeWindow.addEventListener("message", listener, true)
            },
            removeMessageListener: function(listener){
                nativeWindow.removeEventListener("message", listener, true)
            }
        };
    }



    var thisWindow = wrapWindow(window);



    return {
        open : F2(function(url, name, specs){
            thisWindow.open(url, name, specs);
        }),
        close: function(target){
            (target || thisWindow).close()
        },
        addMessageListener: function(listener){
            thisWindow.addMessageListener(listener);
        },
        removeMessageListener: function(listener){
            thisWindow.removeMessageListener(listener);
        },
        postMessage : F2(function(target, message, targetOrigin, transfers){
            target.postMessage(message, targetOrigin, transfers);
        })
    }
}();