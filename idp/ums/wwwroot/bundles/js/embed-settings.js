var getLinkInputObj="",getLinkCopyLinkobj="",isChrome=-1!=navigator.userAgent.indexOf("Chrome");function getEmbedSecret(){$("#get-embed-code").html().trim()==window.Server.App.LocalizationContent.ResetHeader?($(".message-content").addClass("messagebox-align"),isChrome||$(".message-content").css("vertical-align","initial"),messageBox("su su-embed",window.Server.App.LocalizationContent.ResetHeader,window.Server.App.LocalizationContent.ResetConfirmationMessage,"error",resetEmbedSecret)):$.ajax({type:"POST",url:isResetEmbedSecretUrl,success:function(e){e.status&&(secretCodeChange(e),$("#get-embed-code").html(window.Server.App.LocalizationContent.ResetHeader),$("#secret-code-copy").removeAttr("disabled"))}})}function resetEmbedSecret(){onCloseMessageBox(),showWaitingPopup("body"),$.ajax({type:"POST",url:isResetEmbedSecretUrl,success:function(e){e.status?(secretCodeChange(e),SuccessAlert(window.Server.App.LocalizationContent.EmbedSettings,window.Server.App.LocalizationContent.ResetSecretSuccessAlert,7e3)):WarningAlert(window.Server.App.LocalizationContent.EmbedSettings,window.Server.App.LocalizationContent.ResetSecretfailureAlert,e.Message,7e3),hideWaitingPopup("body")}})}function secretCodeChange(e){$("#secret-code-copy").tooltip("hide").attr("data-original-title",window.Server.App.LocalizationContent.LinkCopy$).tooltip("fixTitle"),$("#secret-code").removeAttr("disabled"),$("#secret-code-copy").removeAttr("disabled"),$("#secret-code").val(e.resetEmbedSecret),$(".secret-code-notification").show()}$(function(){var t=$("#secret-code"),i=$("#secret-code-copy");$("#restrict-embed-enabled").is(":checked")||$("#import-validation-msg").html(""),embedEnabled||($("#trigger-file").attr("disabled","disabled"),$("#filename").attr("disabled","disabled")),$(document).ready(function(){i.tooltip("enable").attr("data-original-title",window.Server.App.LocalizationContent.LinkCopy$).tooltip("fixTitle").tooltip("enable")}),$(document).on("click","#restrict-embed-enabled",function(){var e;$("#restrict-embed-enabled").is(":checked")?($("#get-embed-code").removeAttr("disabled"),$("#filename").val(jsonFileName),""!=t.val()&&(t.removeAttr("disabled"),i.removeAttr("disabled")),e="true",$(".download-template").show(),$("#trigger-file").removeAttr("disabled"),$("#filename").removeAttr("disabled"),i.css("cursor","pointer"),i.tooltip("enable").attr("data-original-title",window.Server.App.LocalizationContent.LinkCopy$).tooltip("fixTitle").tooltip("enable")):($("#get-embed-code").attr("disabled","disabled"),$("#filename").val(window.Server.App.LocalizationContent.BrowseJsonFilePath),t.val(""),$(".secret-code-notification").hide(),t.attr("disabled","disabled"),i.attr("disabled","disabled"),i.tooltip("disable").attr("data-original-title",window.Server.App.LocalizationContent.LinkCopy$).tooltip("fixTitle").tooltip("disable"),i.css("cursor","default"),$(".download-template").hide(),$("#trigger-file").attr("disabled","disabled"),$("#cs-upload").attr("disabled","disabled"),$("#filename").attr("disabled","disabled"),$("#import-validation-msg").html(""),e="false"),$("#restrict-embed-enabled").attr("disabled","disabled"),$(".embed-loader").removeClass("embed-loading"),$.ajax({type:"POST",url:updateSystemSettingsValueUrl,data:{systemSettingValue:e,key:"IsEmbedEnabled"},success:function(e){e.status?$("#restrict-embed-enabled").removeAttr("disabled"):($("#restrict-embed-enabled").removeAttr("disabled"),$("#restrict-embed-enabled").is(":checked")?$("#restrict-embed-enabled").attr("checked",!1):$("#restrict-embed-enabled").attr("checked",!0)),$(".embed-loader").addClass("embed-loading")}})}),$(document).on("click","#restrict-embed-enabled",function(){$("#restrict-embed-enabled").is(":checked")||$("#secret-code-copy").attr("disabled",!0).tooltip("enable").css("cursor","pointer")}),$(document).on("click","#secret-code-copy",function(){""!=$("#secret-code").val()&&copyToClipboard("#secret-code","#secret-code-copy")}),i.removeClass("focusdiv"),t.on("focusin",function(){i.addClass("focusdiv")}),t.on("focusout",function(){i.removeClass("focusdiv")})}),$(document).on("click","#trigger-file,#filename",function(){$("#restrict-embed-enabled").is(":checked")&&($("#csfile").trigger("click"),$("#csfile").focus())}),$(document).on("change","#csfile",function(e){var t=$(this).val();"json"!=$(this).val().substring($(this).val().lastIndexOf(".")+1)?($("#cs-upload").attr("disabled",!0),$("#filename").val(window.Server.App.LocalizationContent.JsonFileValidator),$("#filename,#trigger-file").addClass("validation-message"),$(".upload-box").addClass("e-error")):($("#cs-upload").attr("disabled",!1),$("#filename,#trigger-file").removeClass("validation-message"),$("#filename").val(t),$(".upload-box").removeClass("e-error"),$("#csfile").attr("title",t))});