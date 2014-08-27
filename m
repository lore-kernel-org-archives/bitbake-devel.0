Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 695BB71187
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:49 +0000 (UTC)
Received: by mail-wi0-f179.google.com with SMTP id f8so808923wiw.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZMdD5rFIm9PLOu3t3uFaoQ5nByCSRtn1BVnc72WWzLw=;
	b=J78yfVAyVt30umUUS3Nr4DgcN/TYnn7wlfdaKRuYbzZGr6+nZ1hiL8IUsNycNR7g5p
	QpEY5IRRP4+peLoOP6DIQOovRaIF0Q++JMs/USfgavqpthK2bv9q3CkO7qrpbAtgDzul
	mPGIDFiWIpnUdS5fpBdOqL4dF9y0yXaI218ZGcatZjCFtwQYA+TnwayZvHfvfg6H/4Rd
	se+i/kxbR0y4yDaI/l2YGISo7hnOZTS5hoWLAN5aO3qrdYg5eoJFfGV+vi5S3vNEUFUK
	Ho2x02qRXqBPTOuUv+MU5hAry9Z3wcehSXyLpBZW74ueqJJcGyx6lHCdSaqDqJs4c77w
	3HDw==
X-Gm-Message-State: ALoCoQkISfBUyzBw8ldffNs6bcY/Fv1xsckP1uFfx4kfE9+gAVPtfgsWF4KZc6x5lP9x5mcw5edp
X-Received: by 10.180.37.77 with SMTP id w13mr30130488wij.78.1409160230266;
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h3sm2647616wjz.24.2014.08.27.10.23.47
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8465A56119B; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:38 +0100
Message-Id: <018442e53d2f0eb6acef23464a7d8a2bb586cef3.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 06/11] toaster: add all layers page
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Aug 2014 17:23:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a page where the user can browse
and import layers from all the layers known
by Toaster.

[YOCTO #6590]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/layers.html | 173 +++++++++++++++++++++++++++
 lib/toaster/toastergui/views.py              |  74 +++++++++++-
 2 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100755 lib/toaster/toastergui/templates/layers.html

diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
new file mode 100755
index 0000000..d7d159e
--- /dev/null
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -0,0 +1,173 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% block pagecontent %}
+                <div class="page-header">
+                    <h1>
+                        All layers
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the layers compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created layers suitable for use on top of OpenEmbedded Core and any layers you have imported"></i>
+                     </h1>
+                </div>
+                <!--div class="alert">
+                    <div class="input-append" style="margin-bottom:0px;">
+                        <input class="input-xxlarge" type="text" placeholder="Search layers" value="browser" />
+                        <a class="add-on btn">
+                            <i class="icon-remove"></i>
+                        </a>
+                        <button class="btn" type="button">Search</button>
+                        <a class="btn btn-link" href="#">Show all layers</a>
+                    </div>
+                </div-->
+                <div id="layer-added" class="alert alert-info lead" style="display:none;"></div>
+                <div id="layer-removed" class="alert alert-info lead" style="display:none;">
+                    <button type="button" class="close" data-dismiss="alert">&times;</button>
+                    <strong>1</strong> layer deleted from <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>
+                </div>
+
+
+{% include "basetable_top.html" %}
+    {% for lv in objects %}
+    <tr class="data">
+            <td class="layer">{{lv.layer.name}}</td>
+            <td class="description">{{lv.layer.summary}}</td>
+            <td class="source"><a href="{% url 'layerdetails' lv.pk %}">{{lv.layer_source.name}}</a></td>
+            <td class="git-repo"><a href="{% url 'layerdetails' lv.pk %}"><code>{{lv.layer.layer_index_url}}</code></a></td>
+            <td class="git-subdir" style="display: table-cell;"><a href="{% url 'layerdetails' lv.pk %}"><code>{{lv.dirpath}}</code></a></td>
+            <td class="branch">{% if lv.branch %}{{lv.branch}}{% else %}{{lv.up_branch.name}}{% endif %}</td>
+            <td class="dependencies">{% for lvs in lv.dependencies.all %}{{lvs.layer.name}}<br/>{%endfor%}</td>
+            <td class="add-layers">
+                <button id="remove-layer-{{lv.pk}}" class="btn btn-danger btn-block remove-layer" title="1 layer deleted" style="display:none;">
+                    <i class="icon-trash"></i>
+                    Delete layer
+                </button>
+                <button id="add-layer-{{lv.pk}}" class="btn  btn-block add-layer" title="1 layer added">
+                    <i class="icon-plus"></i>
+                    Add layer
+                </button>
+            </td>
+     </tr>
+    {% endfor %}
+{% include "basetable_bottom.html" %}
+
+    <!-- Modals -->
+
+    <!-- 'Layer dependencies modal' -->
+    <div id="dependencies-message" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
+        <div class="modal-header">
+            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
+            <h3>meta-acer dependencies</h3>
+        </div>
+        <div class="modal-body">
+            <p><strong>meta-acer</strong> depends on some layers that are not added to your project. Select the ones you want to add:</p>
+            <ul class="unstyled">
+                <li>
+                    <label class="checkbox">
+                        <input type="checkbox" checked="checked">
+                        meta-android
+                    </label>
+                </li>
+                <li>
+                    <label class="checkbox">
+                        <input type="checkbox" checked="checked">
+                        meta-oe
+                    </label>
+                </li>
+            </ul>
+        </div>
+        <div class="modal-footer">
+            <button id="add-layer-dependencies" type="submit" class="btn btn-primary" data-dismiss="modal" >Add layers</button>
+            <button class="btn" data-dismiss="modal">Cancel</button>
+        </div>
+    </div>
+
+    <script src="assets/js/jquery-1.9.1.min.js" type='text/javascript'></script>
+    <script src="assets/js/jquery.tablesorter.min.js" type='text/javascript'></script>
+    <script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
+    <script src="assets/js/bootstrap.min.js" type='text/javascript'></script>
+    <script src="assets/js/prettify.js" type='text/javascript'></script>
+    <script src="assets/js/jit.js" type='text/javascript'></script>
+    <script src="assets/js/main.js" type='text/javascript'></script>
+
+    <script>
+     $(document).ready(function() {
+
+        //show or hide selected columns on load
+        $("input:checkbox").each(function(){
+            var selectedType = $(this).val();
+            if($(this).is(":checked")){
+                $("."+selectedType).show();
+            }
+            else{
+                $("."+selectedType).hide();
+            }
+        });
+
+        // enable add layer button
+        $('#add-layer-with-deps').removeAttr('disabled');
+
+        //edit columns functionality (show / hide table columns)
+        $("input:checkbox").change();
+            $("input:checkbox").change(function(){
+                var selectedType = $(this).val();
+                    if($(this).is(":checked")){
+                        $("."+selectedType).show();
+                    }
+                    else{
+                        $("."+selectedType).hide();
+                    }
+            });
+
+        //turn edit columns dropdown into a multi-select menu
+        $('.dropdown-menu input, .dropdown-menu label').click(function(e) {
+            e.stopPropagation();
+        });
+
+        //show tooltip with applied filter
+        $('#filtered').tooltip({container:'table', placement:'bottom', delay:{hide:1500}, html:true});
+
+        $('#filtered').click(function() {
+            $(this).tooltip('hide');
+        });
+
+        //show layer added tooltip
+        $("#remove-layer, #add-layer, #add-layer-with-deps2").tooltip({ trigger: 'manual' });
+
+        // add layer without dependencies
+        $("#add-layer").click(function(){
+            $('#layer-removed').hide();
+            $('#layer-added').html('<button type="button" class="close" data-dismiss="alert">&times;</button><strong>1</strong> layer added to <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>').fadeIn();
+            $('#add-layer').tooltip('show');
+            $("#add-layer").hide();
+            $(".add-layers .tooltip").delay(2000).fadeOut(function(){
+                $("#remove-layer").delay(300).fadeIn();
+            });
+        });
+
+        // add layer with dependencies
+        $(document).on("click", "#add-layer-dependencies", function() {
+            $('#layer-removed').hide();
+            $('#layer-added').html('<button type="button" class="close" data-dismiss="alert">&times;</button><strong>3</strong> layers added to <a href="project-with-targets.html">your project</a>: <a href="#">meta-acer</a> and its dependencies <a href="#">meta-android</a> and <a href="#">meta-oe</a>').delay(400).fadeIn(function(){
+                $('#add-layer-with-deps').tooltip('show');
+                $("#add-layer-with-deps, #add-layer-with-deps").hide();
+                $(".add-layers .tooltip").delay(2000).fadeOut(function(){
+                    $("#remove-layer-with-deps").delay(300).fadeIn();
+                });
+            });
+        });
+
+        // delete layer
+        $("#remove-layer").click(function(){
+            $('#layer-added').hide();
+            $('#layer-removed').show();
+            $('#remove-layer').tooltip('show');
+            $("#remove-layer").hide();
+            $(".add-layers .tooltip").delay(2000).fadeOut(function(){
+                $("#add-layer").delay(300).fadeIn();
+            });
+        });
+
+     });
+
+</script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index cad2357..5b23365 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1849,6 +1849,9 @@ if toastermain.settings.MANAGED:
         except User.DoesNotExist:
             puser = None
 
+        # we use implicit knowledge of the current user's project to filter layer information, e.g.
+        request.session['project'] = prj
+
         context = {
             "project" : prj,
             #"buildrequests" : prj.buildrequest_set.filter(state=BuildRequest.REQ_QUEUED),
@@ -1926,7 +1929,76 @@ if toastermain.settings.MANAGED:
         raise Exception("TODO: implement page #6595")
 
     def layers(request):
-        raise Exception("TODO: implement page #6590")
+        # "TODO: implement page #6590"
+        template = "layers.html"
+        # define here what parameters the view needs in the GET portion in order to
+        # be able to display something.  'count' and 'page' are mandatory for all views
+        # that use paginators.
+        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'layer__name:-' };
+        retval = _verify_parameters( request.GET, mandatory_parameters )
+        if retval:
+            return _redirect_parameters( 'layers', request.GET, mandatory_parameters)
+
+        # boilerplate code that takes a request for an object type and returns a queryset
+        # for that object type. copypasta for all needed table searches
+        (filter_string, search_term, ordering_string) = _search_tuple(request, Layer_Version)
+
+        queryset_all = Layer_Version.objects.all()
+        if 'project' in request.session:
+            queryset_all = queryset_all.filter(up_branch = request.session['project'].branch)
+
+        queryset_with_search = _get_queryset(Layer_Version, queryset_all, None, search_term, ordering_string, '-layer__name')
+        queryset = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
+
+        # retrieve the objects that will be displayed in the table; layers a paginator and gets a page range to display
+        layer_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+
+
+        context = {
+            'objects' : layer_info,
+            'objectname' : "layers",
+            'default_orderby' : 'completed_on:-',
+
+            'tablecols' : [
+                {   'name': 'Layer',
+                    'orderfield': _get_toggle_order(request, "layer__name"),
+                    'ordericon' : _get_toggle_order_icon(request, "layer__name"),
+                },
+                {   'name': 'Description',
+                    'dclass': 'span4',
+                },
+                {   'name': 'Layer source',
+                    'qhelp': "Where the layer is coming from, for example, if it's part of the OpenEmbedded collection of layers or if it's a layer you have imported",
+                    'orderfield': _get_toggle_order(request, "layer_source__name"),
+                    'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
+                    'filter': {
+                        'class': 'layer',
+                        'label': 'Show:',
+                        'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
+                    }
+                },
+                {   'name': 'Git repository URL',
+                    'dclass': 'span6',
+                    'qhelp': "The Git repository for the layer source code",
+                },
+                {   'name': 'Subdirectory',
+                    'qhelp': "The layer directory within the Git repository",
+                },
+                {   'name': 'Branch, tag o commit',
+                    'qhelp': "The Git branch of the layer. For the layers from the OpenEmbedded source, the branch matches the Yocto Project version you selected for this project",
+                },
+                {   'name': 'Dependencies',
+                    'qhelp': "Other layers a layer depends upon",
+                },
+                {   'name': 'Add | Delete',
+                    'dclass': 'span2',
+                    'qhelp': "Add or delete layers to / from your project ",
+                },
+
+            ]
+        }
+
+        return render(request, template, context)
 
     def layerdetails(request, layerid):
         raise Exception("TODO: implement page #6591")
-- 
1.9.1


