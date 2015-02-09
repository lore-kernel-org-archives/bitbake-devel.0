Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 36A29732A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:11 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id lj1so35230856pab.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=lhJCYvU51/z25lDfZP4EmHj2NqWhx+wUjNc+nGL7CZU=;
	b=GCjpX3vWtiTdbqEmgbdc0JbhXqmM20P8tjDY0udc83tatrBuAFWtY/DlPtZDNeBhwr
	jvN5qaDBmrFZ5pJX0WosCXnjI79gY9kjcTCsHow8fzkZZkLc2QKfVzrd0urzHX3VCDmi
	i1V4kXpUnAaznO7NUxR2buhf58sDR3bhcFDF4vqrxHLJJ1DyTg2xDKr44OyhvEeobW7A
	n/tvyC3hzU60LJtz0y4P0ezwL7bwcCsuyB/Cy0032tvi2aDPueMCUMJ/YtljJs3dFJdz
	JNPaAfZJUAJqOXZC7I44bfP+iXWsteNkjN9PV40oDDOPQEXGYjEIm/ZA6uE4RGb05bDv
	7orQ==
X-Gm-Message-State: ALoCoQlEm4qWS+eIfUTbT7hoVv2fd1KDodkboQohdJ4WMKvv+lGpBhDcBR591BmQaz437cj1b5J/
X-Received: by 10.68.201.225 with SMTP id kd1mr31134948pbc.11.1423504933424;
	Mon, 09 Feb 2015 10:02:13 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fr13sm16987204pdb.81.2015.02.09.10.02.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 671685661C1; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:52 +0000
Message-Id: <97366eae1d5c2c84b03b3e019480e56e03f812da.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 22/27] toaster: All Machines fix reset search link
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:12 -0000

From: Michael Wood <michael.g.wood@intel.com>

In firefox this link wasn't valid as it was inside a button element.
Remove this and add a click handler for the button.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/machines.js   | 5 +++++
 lib/toaster/toastergui/templates/machines.html | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/machines.js b/lib/toaster/toastergui/static/js/machines.js
index 1b7ea36..ee8c980 100644
--- a/lib/toaster/toastergui/static/js/machines.js
+++ b/lib/toaster/toastergui/static/js/machines.js
@@ -90,4 +90,9 @@ function machinesPageInit (ctx) {
         window.location.replace(ctx.projectPageUrl);
     }, null);
   });
+
+  $("#show-all-btn").click(function(){
+    $("#search").val("")
+    $("#searchform").submit();
+  });
 }
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index 9930a94..f63e897 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -34,7 +34,7 @@
       {% if objects.paginator.count != 0 %}
         {{objects.paginator.count}} machines found
        {% else %}
-        No Machines found
+        No machines found
        {% endif %}
     {% else %}
 
@@ -54,7 +54,7 @@
     <input type="hidden" name="orderby" value="">
       <input type="hidden" name="page" value="1">
         <button class="btn" type="submit" value="Search">Search</button>
-        <button type="submit" class="btn btn-link"><a href="{%url 'machines' %}">Show all machines</a></button>
+        <button type="submit" class="btn btn-link" id="show-all-btn">Show all machines</button>
       </form>
     </div>
 {% else %}
-- 
1.9.1


