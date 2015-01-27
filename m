Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id C47F572C60
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:36 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id l2so15078503wgh.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=bPORAQvOdA2oCc8KkwsCz/eZtzIijvIDHebHAo8HLqA=;
	b=ONzx/vsd8MuskYT6H62R+Xjm0salCj0hzbq+RN9/yMspPCV1rJ1FjduKbWKD/nyT37
	JRkLVExQWJW5epQX6GAqIpw58ipL+qOIqD6i/4NUg9ULqtHC+83mnpRXtvqkOaY+hXel
	cVk/+X0DVWdyh4aprttrDn/+S7y/3F2UHd6XfuiRzlJ3/8VKg2DByQmqiCi4DxTqftKK
	VTFikCdTRAZBsBz7iFK/+jLmhjU4JrUqYGpWFt+3v66KCBtg2pVxYPwyoFhS4k0kN/y0
	EXSXkKLRM++gw9Fv146dwOXe8U5VmOS29zYO7nkckt6SfhRsBZXGVyGVB4b/fe7tK5m9
	iC1A==
X-Gm-Message-State: ALoCoQlpNAh1XR7EBW7v8yhwhVv6y8D7CjQRz2/WNa81a8+qR4g54QzOY4BaehYQfyYnIpQyEP5W
X-Received: by 10.194.52.66 with SMTP id r2mr3121286wjo.61.1422368856507;
	Tue, 27 Jan 2015 06:27:36 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k1sm2048734wjn.9.2015.01.27.06.27.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AC82056257B; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:28 +0000
Message-Id: <70486fc36c5b6bd6b7b8e846e23ad4062d583877.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 07/14] toastergui: add 'show all' link to no results page
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

When you search for targets or machines in the layer details
page and your search returns no results, you should
see a 'show all' link that you can click to clear the
search and display all table entries.

[YOCTO #7218]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   |  4 ++--
 lib/toaster/toastergui/templates/layerdetails.html | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 2addecd..2793225 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -381,12 +381,12 @@ function layerDetailsPageInit (ctx) {
   });
 
   /* Clear the current search selection and reload the results */
-  $("#target-search-clear").click(function(){
+  $(".target-search-clear").click(function(){
     $("#target-search").val("");
     $(this).parents("form").submit();
   });
 
-  $("#machine-search-clear").click(function(){
+  $(".machine-search-clear").click(function(){
     $("#machine-search").val("");
     $(this).parents("form").submit();
   });
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index a89ffb0..f8f2d7a 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -205,11 +205,14 @@
 
                       <input type="text" id="target-search" name="targets_search" placeholder="Search targets" class="input-xlarge" value="{{request.GET.targets_search}}">
                         {% if request.GET.targets_search %}
-                        <a class="add-on btn" id="target-search-clear">
+                        <a class="add-on btn target-search-clear">
                           <i class="icon-remove"></i>
                         </a>
                         {% endif %}
                         <button type="submit" class="btn">Search</button>
+                        {% if targets.paginator.count == 0 %}
+                            <button type="submit" class="btn btn-link target-search-clear">Show all targets</a>
+                        {% endif %}
                       </form>
                     {% endif %}
 
@@ -332,11 +335,14 @@
 
                       <input type="text" id="machine-search" name="machines_search" placeholder="Search machines" class="input-xlarge" value="{{request.GET.machines_search}}">
                         {% if request.GET.machines_search %}
-                        <a class="add-on btn" id="machine-search-clear">
+                        <a class="add-on btn machine-search-clear">
                           <i class="icon-remove"></i>
                         </a>
                         {% endif %}
                         <button type="submit" class="btn">Search</button>
+                        {% if machines.paginator.count == 0 %}
+                            <button type="submit" class="btn btn-link machine-search-clear">Show all machines</a>
+                        {% endif %}
                       </form>
                     {% endif %}
 
-- 
1.9.1


