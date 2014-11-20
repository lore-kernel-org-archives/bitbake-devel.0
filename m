Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id BBD1365C78
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:41 +0000 (UTC)
Received: by mail-pd0-f178.google.com with SMTP id g10so1134225pdj.37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=95KraEFz5L02Zo+zvDubWq8NA/jLruzbpAbZxzpk4Xs=;
	b=AoNf4n4ZfO/zNDtRyhrM5FtvGFp8ccrhmRn8doCBpPDUg5GrZiFwLIoo7Wq66SZMRx
	W78RFpak8tcVa2zslYH5te0SUIk9gt1KN7+YCD5KFFFkyQ3ZreTRL9TWhJNjToD4ya3g
	OHor3PgPTlg6Hspe9d+/YL4UQnPpgCJp1kNQN2ca8olAzWEtZBRjSHcdFm5fZUrFSGGE
	PF3yNrxQUJ2iLc1+DiwOb+/5+DvzIDZwfR6mlQrnG5vBxRfP1rWRfoXwLm0YEl9ax12F
	eg1YTEsa8DQHU4bLSxpNfS5DfcMLOMtrcFA0fBbAnv7ru9s50jvcjmJitgpIURdFE+Yd
	lHXQ==
X-Gm-Message-State: ALoCoQnCIYEvx1I2u+3sr36xwfmJO3JIlzaHQ8RPONx1IB7ta2bYyeLC+R/ErDhO909tqttDQtuF
X-Received: by 10.66.65.165 with SMTP id y5mr35001639pas.70.1416500860335;
	Thu, 20 Nov 2014 08:27:40 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id uy8sm2491655pab.44.2014.11.20.08.27.37
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:39 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 899855641F9; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:27 +0000
Message-Id: <27023ce2d264ce05008ef9af33982b054c6a87b5.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 11/11] toaster: do not show target if target name is empty
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:42 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

In the all targets table, all entries should have a target
name. If a target does not have a name, something has not
gone to plan, so don't show it.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 lib/toaster/toastergui/templates/targets.html | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 1f938aa..f4313f9 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -39,6 +39,7 @@
 
 {% include "basetable_top.html" %}
     {% for o in objects %}
+    {% if o.name %}
     <tr class="data">
         <td class="target">
                 {{o.name}}
@@ -78,6 +79,7 @@
             </a>
         </td>
     </tr>
+    {% endif %}
     {% endfor %}
 {% include "basetable_bottom.html" %}
 
-- 
1.9.1


