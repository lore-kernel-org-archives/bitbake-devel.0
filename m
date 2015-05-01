Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 5C16872120
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 May 2015 11:47:06 +0000 (UTC)
Received: by wizk4 with SMTP id k4so118283819wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 May 2015 04:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=LhFac90kSa6gLqp2qCXt0t/7geChkvFu6hgfoJySejA=;
	b=JiyQkT1MN7cvtCpJUOj1SUoOtQQvQAVpgf6FafSgQ9kqEoCNnBecWzNgdkYDyfYhby
	yu9+RlMVMRnLzFFL9DGsIjfPAe9NeYbKOg8snq5tvFmeQYQ1Jduh8AR+ilzRi8VFWpCW
	JS1NeZ+a5jpq9W0hkY4MsHzOBfNqAbpZaH8MRhaJJcsOwtNeWYA+7lAFMsUt1BGxz93P
	eCyMvi4Qi+yMGSHGOXh09BYyYnfNx91iKoZzJRoxjAO8VJaan/D+f84SIwXmQmH9KjRw
	WojdYAJBgEIRnyF+82hLPx0w29kiOouLcyckOZ684cA3GZ+KR90PgGgtsWqy/AkXHyII
	gvGw==
X-Gm-Message-State: ALoCoQkaHQHkKOvVYuQr4noWOzZl5oj+DuFyXw4qN7DZFzpnKo/I29xPBJ8W/Iuk5DTPY+h8WA7t
X-Received: by 10.180.94.100 with SMTP id db4mr18817269wib.26.1430740027301;
	Mon, 04 May 2015 04:47:07 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	be3sm10822051wib.21.2015.05.04.04.47.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 May 2015 04:47:04 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 102DD566880; Fri,  1 May 2015 17:40:47 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 May 2015 17:40:46 +0100
Message-Id: <b64bbc2dd51369b64fae2b1a10502b9dd4ceebfd.1430498382.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1ddd6a9e4280a4adf971132ff1fe7ec9b3252905.1430498382.git.alexandru.damian@intel.com>
References: <1ddd6a9e4280a4adf971132ff1fe7ec9b3252905.1430498382.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1430498382.git.alexandru.damian@intel.com>
References: <cover.1430498382.git.alexandru.damian@intel.com>
Subject: [PATCH 7/7] toaster: filtersnippet remove redefinition of filter type key
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
X-List-Received-Date: Mon, 04 May 2015 11:47:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

This redefinition is not needed and also used Mozilla specific API to
access the data thus breaking the date filter in all other browsers.

[YOCTO #7577]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/filtersnippet.js | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/filtersnippet.js b/lib/toaster/toastergui/static/js/filtersnippet.js
index 27b057e..2b84c54 100755
--- a/lib/toaster/toastergui/static/js/filtersnippet.js
+++ b/lib/toaster/toastergui/static/js/filtersnippet.js
@@ -80,8 +80,7 @@ function date_init (key, from_date, to_date, min_date, max_date, initial_enable)
     $("form").unbind('submit');
     $("form").submit(function(e) {
         // format a composite daterange filter value so that it can be parsed and post-processed in the view
-        var key=e.originalEvent.explicitOriginalTarget.getAttribute("data-key")
-        if (typeof key != "undefined") {
+        if (key !== undefined) {
             if ($("#date_from_"+key).length) {
                 var filter=key+"__gte!"+key+"__lt:"+$("#date_from_"+key).val()+"!"+$("#date_to_"+key).val()+"_daterange";
                 $("#last_date_from_"+key).val($("#date_from_"+key).val());
-- 
1.9.1


