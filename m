Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id BA7E6756EF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:14:28 +0000 (UTC)
Received: by wgv5 with SMTP id 5so37732420wgv.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4qLwRacRaMKIgqT6pIuUnZ3DOgDGg+92+cC6vwLUnAo=;
	b=SGufESs/gsDZHI40DcNPf6SI3/AKs4XICIlL/3ElVwaCAwjq/b/FCVgrqnfywjW7AK
	nV7dhb3dUwHwfUAGWVf30czSrQZmIeSgy+k0/Me2Qtl72SrmOvThbI5IQ1loavHDB23p
	CPJlCmXZqeOVr8xNNDJfhOL5z+mDuki3zUD24HHcWYLOnBVz8NusDTmFyG0sIKItC/3z
	nNl5KifezouexA7QDOkO1SZ49f98GIYr+31sTwzBfprSMwBcDWT4+so6jwF+xon24ouh
	59Vm6y6YSzkYSN8IDjkzVEWtmqT7bbUT/KVc3mnqhIB7E20RWXDucRuG7b1CjiTZ99Dn
	+YNw==
X-Gm-Message-State: ALoCoQkwSQ7WPra5n7f9Pei+fgGNyGOa7q4hz9NtfwQIK2+i/2a1pHsk/4em5vu0LSEHdAahoQmJ
X-Received: by 10.180.77.195 with SMTP id u3mr16628535wiw.30.1432822468425;
	Thu, 28 May 2015 07:14:28 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n3sm27274539wix.1.2015.05.28.07.14.27
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:14:27 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B2D83561175; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:13:55 +0100
Message-Id: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 01/22] toaster: Fix build button current project race
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
X-List-Received-Date: Thu, 28 May 2015 14:14:28 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make sure the current project value is set before we check to see if the
project is buildable. Also update the blacklist url patterns where we
aren't displaying the button.

[YOCTO #7739]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index c4c96c8..ccc23e0 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -6,11 +6,13 @@ function basePageInit (ctx) {
   /* Hide the button if we're on the project,newproject or importlyaer page
    * or if there are no projects yet defined
    */
-  if (ctx.numProjects == 0 || ctx.currentUrl.search('newproject|project/\\d/$|importlayer/$') > 0){
+  if (ctx.numProjects == 0 || ctx.currentUrl.search('newproject|project/\\d$|importlayer$') > 0){
       newBuildButton.hide();
       return;
   }
 
+  var currentProjectId = libtoaster.ctx.projectId;
+
   /* Hide the change project icon when there is only one project */
   if (ctx.numProjects == 1){
      $('#project .icon-pencil').hide(); 
@@ -21,7 +23,6 @@ function basePageInit (ctx) {
   _checkProjectBuildable()
   _setupNewBuildButton();
 
-  var currentProjectId = libtoaster.ctx.projectId;
 
   function _checkProjectBuildable(){
     if (currentProjectId == undefined)
-- 
1.9.1


