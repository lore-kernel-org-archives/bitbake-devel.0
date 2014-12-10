Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id AEBA57262E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:22 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id r20so13620064wiv.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ppHcTEnlc2zUwssZ/Y1j98NFXj/mf6HmptLXjq04Zkw=;
	b=dwDRx7RxJHdT4eh17AU/vZ/DLjauoyg4blAr/C9REXF0J58Rt7X9zT5TP9oerPb2Mi
	8VIVWvNz5JjjdfBXdO1toy9XLkn91ud4qfipm7VEDmdeNI00b0768Opz6lSpUmy5ZjX1
	knqHVPDn30N6wnw/kuKiCQ4iMyMXFw6aEXH0PFgvwPjJfIAOz4F8RgBTi41eWYrPJtq2
	sODlCW4PZzoZSW6gdl0sbY8y0etsT2hroTP1s+UUmmYBgdQUnQlJxiyoAVEeQ+MY5tZz
	wJWZZ9NLHAJdgPHYGA53llLvAgvi8bM8AOYO2CjXCf77+Svz8fcXHaAsaWV4S46cFtAy
	oCqw==
X-Gm-Message-State: ALoCoQlNpStgnKHXZo2m3I6sdSoOrZsYQWsS6lXeeIGag24QUrOND0izMYtNwgiVTsya41krnRUj
X-Received: by 10.180.95.97 with SMTP id dj1mr13863927wib.43.1418224342050;
	Wed, 10 Dec 2014 07:12:22 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id vy7sm6214443wjc.27.2014.12.10.07.12.19
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:20 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 704E156472C; Wed, 10 Dec 2014 15:12:17 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:12 +0000
Message-Id: <1c11aa904b0719799cd9126d268c5950a4dc666e.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
References: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
Subject: [PATCH 07/11] toaster: Initialise the 'change' icon tooltips
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
X-List-Received-Date: Wed, 10 Dec 2014 15:12:24 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

All 'change' icons should have a tooltip that appears
when you hover over them. The tootlip says (fittingly):
"Change". Initialise those icons in the libtoaster.js
file so that they work outside the project page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 8e76ecb..37fc80e 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -213,6 +213,9 @@ $(document).ready(function() {
     // show task type and outcome in task details pages
     $(".task-info").tooltip({ container: 'body', html: true, delay: {show: 200}, placement: 'right' });
 
+    // initialise the tooltips for the icon-pencil icons
+    $(".icon-pencil").tooltip({ container: 'body', html: true, delay: {show: 400}, title: "Change" });
+
     // linking directly to tabs
     $(function(){
           var hash = window.location.hash;
-- 
1.9.1


