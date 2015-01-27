Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id A894572D0D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:38 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id r20so5206264wiv.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=D1ihiiyE6/zHzdqIH3T/P9QN2disfG6LMqbFJkod9OY=;
	b=JB4PeZoaNRtHTlM6/MKLso395bJjEy466wm9O+7IPM883ki9ewkLkumK3N7omAyn0q
	MgowGy3tnCZ/Kum2/5fRhz7SqT+6Bnrys+IUVnNylMhrrCwpr1cr1RvdKGtnVh5TRBFS
	v98A8KpvZ7badSnxY/z40L5mnAR64kMx/wBZ4LZZvJPTtcyThalxsMURkYBsgLsVBsAK
	VGHtUwuCmj8ymY7L0HrAEbaHdCAS3aN7dIFalcs/qdUqSW8pu6plWCIMfFptR8hBldWq
	pQNTh5EAgatdM9a5cwuFD0g10E6n+Jo7ukzTjvmZmSO5+oEo8SCc14m9Lb8M+WnUbof7
	jrRg==
X-Gm-Message-State: ALoCoQn7uO8EotQN8S8FUirt4GobzPg2hsfjMwL9LYtC4qK1dNzVsbVfJ5HgGoj/PQEb9HwFmqoN
X-Received: by 10.194.239.104 with SMTP id vr8mr3362491wjc.124.1422368858641; 
	Tue, 27 Jan 2015 06:27:38 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id bj3sm18354386wib.3.2015.01.27.06.27.35
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B3B22562664; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:33 +0000
Message-Id: <8be4a8cf1673112e9e613e719fa6ed96dbca8976.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 12/14] toastergui: alignment fix
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

Align horizontally the pagination and show rows
controls at the bottom of the layer details page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 84a21d7..4ffd071 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -295,8 +295,8 @@
                       {%endif%}
                     </ul>
                     <div class="pull-right">
-                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+                      <span class="help-inline" style="padding-bottom:10px;">Show rows:</span>
+                      <select class="pagesize">
                         {% with "10 25 50 100 150" as list%}
                         {% for i in list.split %}
                         {% if request.session.limit == i %}
@@ -421,8 +421,8 @@
                       {%endif%}
                     </ul>
                     <div class="pull-right">
-                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+                      <span class="help-inline" style="padding-bottom:10px;">Show rows:</span>
+                      <select class="pagesize">
                         {% with "10 25 50 100 150" as list%}
                         {% for i in list.split %}
                         {% if request.session.limit == i %}
-- 
1.9.1


