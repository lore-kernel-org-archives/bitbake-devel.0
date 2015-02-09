Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id E175A606E9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:08 +0000 (UTC)
Received: by pdbfl12 with SMTP id fl12so8029599pdb.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EHqdEG3+qhu0tKWgU6OK/vIi9NXVVXiieoFwdZliTbo=;
	b=Z/+jMZaFSi+J6ATDy372DKYZLnX/kr3GM1YdU7RsFjdKDOtkgtrupuAbrl8KVaUzQp
	aisYjzaAYX8Fc+GKemx/7mpywJmqK/iI/lla621FZfTLTPhX1r54NIhrVRAXlYJmfy+O
	P3HRZqMB35RPCzETX9AokANr4M6LGm1mgQ5SBoFHfRQ5M+bhaFQFWLo/1Q0TvcPp4uMC
	53tzxLyNFS2usvM/lAxnkCtCylP9kurdYyL+kPXw3VQFyhRAoS8r+Thvt2SCS1csVoIw
	fRc6yCIyGK4RAn0ZBoWdHaibgIGSDL13H9NuH3+3fWoqmYcQzQIp5mgvFWeXWyvv+tkK
	2eXQ==
X-Gm-Message-State: ALoCoQmW3M2LomB2ChdLiQi03lPrxvhQvqGOOjl0nBh00nDOEuC2q9Fz5RnfYohUXLTHyg09iWUY
X-Received: by 10.68.131.39 with SMTP id oj7mr30899058pbb.145.1423504930055;
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	t10sm16992425pdr.75.2015.02.09.10.02.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:09 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5A8AD5661A8; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:43 +0000
Message-Id: <388cfb26695ffd6ac0498e5de571cd4a5e083f8b.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 13/27] toaster: machines Fix undefined variables
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

pagesize and orderby were undefined causing an error to be thrown when
browsing to the all machines page

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9567e62..73a5c7e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2774,6 +2774,7 @@ if toastermain.settings.MANAGED:
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
+        (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:+')
         mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'name:+' };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-- 
1.9.1


