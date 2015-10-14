Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 2B6FA770AB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 14:43:57 +0000 (UTC)
Received: by wicll6 with SMTP id ll6so616047wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 07:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jNaWqR4tY4cfugQTa2vlGkPOAMTqzG5ql/+YpNaXc2A=;
	b=Jm/VHeRvc9+j0ID+2roMJrj2aHlp8SeK1e4/QQZxFpYj+1bvuxXlrYCCyIQi9UnljW
	Ejnz/RWm2ASGJMmU4xjvI7JDkGxMWSXwukSRqq82eyHr35ALD71X8agdN2/bwzb6WYGE
	W3DXWlhYYGDlNtYxp5cHmrowvXsl1thSlH+ZhCYIJ72qRQfTbidlk4Xc538KxT6MDtFH
	oCXQb2nYFMpQtjHJheRAK0DzBzO6+VL6oTVM7i3/AoY/JJfmDXQwVa8NrTASY26lPDqx
	L/KmDpajFeDXYZynfGsvDj2MUgFflFO5yk1DJcpEFN6yP1zM+KFpfYhGFlliSWpBjQ2A
	wG7w==
X-Gm-Message-State: ALoCoQnFTcaqpyrDIJZgsxxTx721igQ1XkSEs1ww8dcaE8ocpmtLVrQMK8ziVPnr5qC0thd82TOb
X-Received: by 10.194.123.193 with SMTP id mc1mr4608376wjb.154.1444833835347; 
	Wed, 14 Oct 2015 07:43:55 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	p7sm10466970wjf.26.2015.10.14.07.43.54
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 07:43:54 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 15:43:44 +0100
Message-Id: <98534c29dbaabc742bd106265abe6f3cde17be0f.1444830820.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b6b577253c245392800ea5e78391d11cef8eb8c8.1444830820.git.michael.g.wood@intel.com>
References: <cover.1444830820.git.michael.g.wood@intel.com>
	<b6b577253c245392800ea5e78391d11cef8eb8c8.1444830820.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1444830820.git.michael.g.wood@intel.com>
References: <cover.1444830820.git.michael.g.wood@intel.com>
Subject: [PATCH 2/3] toaster: Check whether buildrequest exists before using it
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
X-List-Received-Date: Wed, 14 Oct 2015 14:44:00 -0000

From: Elliot Smith <elliot.smith@intel.com>

Builds initiated from the command line don't have a buildrequest
associated with them. The build.buildrequest association is
only added if a build is triggered from toaster.

Some of the code for displaying the status of a build refers
to build.buildrequest without checking whether it has been set,
which causes an error to be thrown.

Add a guard to check whether the buildrequest has been set.

[YOCTO #8277]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 1cbf480..44a453a 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -344,6 +344,9 @@ class Build(models.Model):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
         return( tgts );
 
+    def get_outcome_text(self):
+        return Build.BUILD_OUTCOME[int(self.outcome)][1]
+
     @property
     def toaster_exceptions(self):
         return self.logmessage_set.filter(level=LogMessage.EXCEPTION)
@@ -361,10 +364,23 @@ class Build(models.Model):
         return (self.completed_on - self.started_on).total_seconds()
 
     def get_current_status(self):
+        """
+        get the status string from the build request if the build
+        has one, or the text for the build outcome if it doesn't
+        """
+
         from bldcontrol.models import BuildRequest
-        if self.outcome == Build.IN_PROGRESS and self.buildrequest.state != BuildRequest.REQ_INPROGRESS:
+
+        build_request = None
+        if hasattr(self, 'buildrequest'):
+            build_request = self.buildrequest
+
+        if (build_request
+                and build_request.state != BuildRequest.REQ_INPROGRESS
+                and self.outcome == Build.IN_PROGRESS):
             return self.buildrequest.get_state_display()
-        return self.get_outcome_display()
+        else:
+            return self.get_outcome_text()
 
     def __str__(self):
         return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
-- 
2.1.4


