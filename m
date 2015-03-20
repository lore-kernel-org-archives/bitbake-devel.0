Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 5C88C739BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:42 +0000 (UTC)
Received: by padcy3 with SMTP id cy3so105005141pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=kMMn1dQp6sjzEIZkzg/e1EDhqXsxjkSzJWmPpjzWWR4=;
	b=JBrFSua9mfC06mYGon12LxW4OnzUlKRLSu05yiweMD3E1NEcbsHCCimEL4RH8aikro
	UA1YB5Bz3fDhlJoeSkt1YwhAP/tXo1qYCz7ZgfvG4Pm+Lr0KEL3vpW86SR47Le4QbD+J
	Ps7vNK3q9WulyhTDpa31Iaiq1FA05flKlb6Kf+JTGz3VAxgaPL4UQImVo4gdu/F8AFmU
	Uk2tXfYOXaBK1R6KkNOQiOWRHGEAb3uTD0/aY6hFfYZZtNFzhVZrteKGiupmu7gPPgua
	ueCZscU4PExMHcwRGJoO6zb9nGvZoyKL2giAL74W1mYmuB2KBc5MOObZ9WTH8te8eV8Q
	v19g==
X-Gm-Message-State: ALoCoQldwNM83NTdGaw3JLkbkkulRKqLGrArZNaz6PjbUk1rmIgYlB3R6kNIBocPn5nV0mgcYRAs
X-Received: by 10.70.53.40 with SMTP id y8mr156401554pdo.61.1426847143591;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fx13sm7449394pdb.7.2015.03.20.03.25.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BC9CF5645C6; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:30 +0000
Message-Id: <3592c738d9810afb79c447d6bc48ff3a5c754f2d.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 13/14] toaster: display machine and project values in input fields
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:42 -0000

From: David Reyna <David.Reyna@windriver.com>

Explicitly preset the machine and project values in their respective
input fields.

[YOCTO #7170]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/project.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 35147c0..0f538b9 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -355,7 +355,7 @@ vim: expandtab tabstop=2
               You cannot really compare the builds for the new machine with the previous ones.
         </div>
         <form ng-submit="editProjectSettings('#select-machine')" class="input-append">
-              <input type="text" id="machine" autocomplete="off" ng-model="machineName" typeahead="m.name for m in getAutocompleteSuggestions('machines', $viewValue)" typeahead-template-url="suggestion_details" />
+              <input type="text" id="machine" autocomplete="off" ng-model="machineName" value="{[machine.name]}" typeahead="m.name for m in getAutocompleteSuggestions('machines', $viewValue)" typeahead-template-url="suggestion_details" />
               <input type="submit" id="apply-change-machine" class="btn" type="button" ng-disabled="machineName == machine.name || machineName.length == 0" value="Save"></input>
               <input type="reset" id="cancel-machine" class="btn btn-link" ng-click="toggle('#select-machine')" value="Cancel"></input>
               {% csrf_token %}
@@ -391,7 +391,7 @@ vim: expandtab tabstop=2
     </p>
     <div id="change-project-name" style="display:none;">
       <form ng-submit="editProjectSettings('#change-project-name')" class="input-append">
-        <input type="text" class="input-xlarge" id="type-project-name" ng-model="projectName">
+        <input type="text" class="input-xlarge" id="type-project-name" ng-model="projectName" value="{[project.name]}">
         <input type="submit" class="btn" value="Save" ng-disabled="project.name == projectName"/>
         <input type="reset" class="btn btn-link" value="Cancel" ng-click="toggle('#change-project-name')">
      </form>
-- 
1.9.1


