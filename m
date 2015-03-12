Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 17EE773B53
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:51 +0000 (UTC)
Received: by wiwh11 with SMTP id h11so36139734wiw.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RakWcjARVIH7miIERZGqQguPg/kZT/mSdE+VEE/WLPk=;
	b=iobxe917aU052pnNPlXPNUhVXx/J0sXcUiVnseKvrAxU6+d+pbU8bBZxbcvxaIfLrV
	Ra0+tys239wN8wZNP78DQQ5FxIIYd8sLpbHJjRw+WRGUd42Z9Kg+N3ZF9WcZ1pZi/f3T
	Q0BjMf1GHO4hM0s5GkqgcPAtDQ3EF+3iqDudS8jeZ/V8tB5+J0dAfDXoSSOvwgKjXzgS
	AvFlEPzEsCEgN9wdepPmlZ23BqUM4pE3bUR+FKXM7wcDl6RXGvKdGCij+3XPoHqhRV0b
	kMtsS63hz35haTmcH3Huetn2SEKjmENXMmuKKsyuWFeLM4bg8as6K8mqGQ1l6U/PgAx5
	4tDw==
X-Gm-Message-State: ALoCoQn7XMJbWPcNcjphps/aitybYcwIaeZ3ZDfH+4fuQnlU7jrEZ6DairDw7znz9gp0W/yyafPp
X-Received: by 10.180.107.71 with SMTP id ha7mr130881365wib.23.1426157212652; 
	Thu, 12 Mar 2015 03:46:52 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id j7sm10127442wix.4.2015.03.12.03.46.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6C85456201A; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:41 +0000
Message-Id: <48f11489aca033f76bb9175a4088ba524cfdffc6.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 08/17] toastergui: project app build command fix
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the build command in the angular
project for builds triggered from All targets page.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 82db107..6b1bbb4 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -327,7 +327,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         }).error(function(_data, _status, _headers, _config) {
             if (_status === 0) {
                 // the server has gone away
-                alert("The server is not responding. The application will terminate now");
+                // alert("The server is not responding. The application will terminate now");
                 $interval.cancel($scope.pollHandle);
             }
             else {
@@ -652,9 +652,9 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
      */
 
     $scope.updateDisplayWithCommands = function() {
-        cmd = $location.path();
 
         function _cmdExecuteWithParam(param, f) {
+            var cmd = $location.path();
             if (cmd.indexOf(param) === 0) {
                 if (cmd.indexOf("=") > -1) {
                     var parameter = cmd.split("=", 2)[1];
@@ -725,8 +725,9 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         _cmdExecuteWithParam("/targetbuild=", function (targets) {
             var oldTargetName = $scope.targetName;
             $scope.targetName = targets.split(",").join(" ");
-            $scope.targetNamedBuild();
+            $scope.buildNamedTarget();
             $scope.targetName = oldTargetName;
+            $location.path('');
         });
 
         _cmdExecuteWithParam("/machineselect=", function (machine) {
-- 
1.9.1


