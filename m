Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 9C9F7732F0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:17 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id et14so35256866pad.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=bky4dZVy9KHQXJuAj0oOWMtcqZFBPIvTx/0g6ilef3M=;
	b=ePZvfFLApYWJUDxDjXOZ62q1YDhIS1ZPLj1tYq1OUOxdDyCtOJEnQ1sV9E9ZcMspnR
	v8Fv9ghL0g7e9b3kodohMg3HHWKdgP2zDcZE/YaJSONRHojBJ5pnEBpHrmz9KaRdz6ur
	s7YQllhf30hcxhTd+5RxV6gIKajd5siKjEg9yemk3ZW493kSn3OZu18bXEFohTjxRBnp
	gUP8wgTFsM4L96fO3Tw9WHX6r5EwOFOJLhuYv6xWJ7MTW8DwmIs5A2fJI6jtMXwMeUVM
	pNbr9yiSdx4RL7z/2SYCVS8RY/NZpkIZiBj9SIHAQ4cYSAfSFI/F6qkSpPB8WsdswnuC
	8Qqg==
X-Gm-Message-State: ALoCoQmhy9yKHEJofrawKyjkzZyiwV+aI5Salu2OqeGHHh9DsIFtrkFHu9rLKAvlw2UByLP5Nrr0
X-Received: by 10.66.141.71 with SMTP id rm7mr3206849pab.114.1423504938485;
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fy8sm14066707pdb.42.2015.02.09.10.02.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 2633F566192; Mon,  9 Feb 2015 18:02:15 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:57 +0000
Message-Id: <5482507210c3bd1c6223fc1e7881ac5c5474fbdf.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 27/27] toastergui: links outside Toaster should open in a new window
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:17 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make sure all links going to pages outside Toaster in
the layer details page (to web repos and the like)
open in a new tab/window.

[YOCTO #7193]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 0321a0b..6d00da3 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -111,7 +111,7 @@
             <dd>
               <span class="current-value">{{layerversion.layer.vcs_url}}</span>
               {% if layerversion.get_vcs_link_url %}
-                <a href="{{layerversion.get_vcs_link_url}}/" class="icon-share get-info"></a>
+                <a href="{{layerversion.get_vcs_link_url}}/" class="icon-share get-info" target="_blank"></a>
               {% endif %}
               <form id="change-repo-form" class="control-group" style="display:none">
                 <div class="input-append">
@@ -130,7 +130,7 @@
                 <span class="muted" style="display:none">Not set</span>
                 <span class="current-value">{{layerversion.dirpath}}</span>
                 {% if layerversion.get_vcs_dirpath_link_url %}
-                  <a href="{{layerversion.get_vcs_dirpath_link_url}}" class="icon-share get-info"></a>
+                  <a href="{{layerversion.get_vcs_dirpath_link_url}}" class="icon-share get-info" target="_blank"></a>
                 {% endif %}
                 <form id="change-subdir-form" style="display:none;">
                   <div class="input-append">
-- 
1.9.1


