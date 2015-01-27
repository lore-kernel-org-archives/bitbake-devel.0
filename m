Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 153F76A9FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:36 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id k14so15031872wgh.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=nkGtwq2obTl2SufQ4lhgv3yHYpht7jbc845u7Isw3Ok=;
	b=KlYV/TN9y8RSKeN2TcLUC7rrv5OWrrjGBiUj9KW0gVEesN/vhCN1jy9H8prR1hlA/o
	RYwITaXKZs0CeJ6hLPl6Jj1AphdYK50NvxNHxR2zufdAT8fb2dPih1p3M0WBvi6Sp3JI
	Q/UTaQhoNI1c4LNiJMNZ1hcYDHsC2fsfTM+ZeaZEmluybqXPEcBH3/0mhATMWuWLzFH5
	o6wxa/1H+5zyGM3afnD7cAiquP1iRat+d65MHSug+9a9qyQ6ohKZqL3PBQHKxTzijcoI
	/eurxO9VstodbG01NUsZTy0fj/cBcg6BRMPKwXULXRgcihAri3Iqx3f4VhYYq0G7lAF8
	t4Bw==
X-Gm-Message-State: ALoCoQk8Iuo5VcAcxM59iM8nYLm8pZuBuQvpSLPAq3wjlbrkiqNjwJinu2adHxgeYxrLC4cBGHDy
X-Received: by 10.181.13.42 with SMTP id ev10mr6410569wid.78.1422368857235;
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id q10sm2016423wjr.41.2015.01.27.06.27.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id ADDF1562594; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:29 +0000
Message-Id: <4282a92fe3652c52448dba3d5f3fc4e1de28be63.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 08/14] toastergui: set column width in layer details page
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

Set the width of the action columns to span2 to stop
the buttons from wrapping as much as possible.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index f8f2d7a..6c5e785 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -254,7 +254,7 @@
                           Target version
                         </th>
                         <th class="span4">Description</th>
-                        <th>Build target</th>
+                        <th class="span2">Build target</th>
                       </tr>
                     </thead>
                     <tbody>
@@ -380,7 +380,7 @@
                           {% endif %}
                         </th>
                         <th>Description</th>
-                        <th>Select machine</th>
+                        <th class="span2">Select machine</th>
                       </tr>
                     </thead>
                     <tbody>
-- 
1.9.1


