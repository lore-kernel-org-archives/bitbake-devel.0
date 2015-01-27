Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id D554E72C83
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:36 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id x12so15085546wgg.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=sVFthzcuwaUA1KPvP26LrXO2yLjg+EmprUA+jnmPVhM=;
	b=H7taSTfj49pP+7YNu5M4PQPkuzJvUd3J/7AXZI+x+VhPnEBnkS7VEq8xDeZplOBIGL
	63e5hvAxWE9TQtsV0ZT7UKo48ZQ3APDTehbLxjidyn3oKhY5fG1bbTj3kfRBOXEngerP
	O2o3nY9dCnRD+p36Xtsh2TahnHNaPUj51B5ELvzATothydaBCCLvoybyZ37paoXyvsKX
	3BcKjHsfr00sWlixRQPtpziI9YrNUAEhwVXdMNxRUBNp8IsXgLn03UMIAhK/1E1gq7H7
	tmWFAUHhkMXG0rLr9ttAQFOSOgpQwin+V/k1tSnBChdZpfq7LSTqnGRsT/fejEIFk16u
	9B6A==
X-Gm-Message-State: ALoCoQlJ0aEnD90slCN8jALKUYD3ez+DGqfoyPvJIUDjgOLyPJzUIXB40ZzAyoUV/Vxspe8RE5u+
X-Received: by 10.194.242.6 with SMTP id wm6mr306745wjc.7.1422368856923;
	Tue, 27 Jan 2015 06:27:36 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id bo3sm2013611wjb.44.2015.01.27.06.27.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AF4B056259E; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:30 +0000
Message-Id: <5399738fb2e2956a7d4ce59699dc4b6f6c67bbb2.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 09/14] toastergui: hide table controls when when less than 10 entries
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

The 'show rows' and pagination controls in the layer details
page should only show when there are more than 10 entries
in a table.

[YOCTO #7217]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 6c5e785..1daf9b9 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -223,6 +223,7 @@
                      </div>
                     {% else %}
 
+                    {% if total_targets > 10 %}
                     <div class="pull-right">
                       <span class="help-inline" style="padding-top:5px;">Show rows:</span>
                       <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
@@ -237,6 +238,7 @@
                       {% endwith %}
                     </select>
                   </div>
+                  {% endif %}
                 </div>
 
                 <table class="table table-bordered table-hover">
@@ -274,6 +276,7 @@
                     </tbody>
                   </table>
 
+                  {% if total_targets > 10 %}
                   <!-- Show pagination controls -->
                   <div class="pagination">
                     <ul>
@@ -308,6 +311,7 @@
                   </div>
                   {% endif %}
                   {% endif %}
+                  {% endif %}
                 </div>
 
 
@@ -351,8 +355,10 @@
                      </div>
                      <!-- end row-fluid -->
                      </div>
+
                     {% else %}
 
+                    {% if total_machines > 10 %}
                     <div class="pull-right">
                       <span class="help-inline" style="padding-top:5px;">Show rows:</span>
                       <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
@@ -367,6 +373,8 @@
                       {% endwith %}
                     </select>
                   </div>
+                  {% endif %}
+
                 </div>
 
                 <table class="table table-bordered table-hover">
@@ -394,6 +402,7 @@
                     </tbody>
                   </table>
 
+                  {% if total_machines > 10 %}
                   <!-- Show pagination controls -->
                   <div class="pagination">
                     <ul>
@@ -428,6 +437,7 @@
                   </div>
                   {% endif %}
                   {% endif %}
+                  {% endif %}
                   </div>
               </div>
             </div>
-- 
1.9.1


