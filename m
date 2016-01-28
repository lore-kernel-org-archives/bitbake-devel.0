Return-Path: <armccurdy@gmail.com>
Received: from mail-ob0-f195.google.com (mail-ob0-f195.google.com
	[209.85.214.195])
	by mail.openembedded.org (Postfix) with ESMTP id F25457706E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jan 2016 00:43:40 +0000 (UTC)
Received: by mail-ob0-f195.google.com with SMTP id wg8so1447623obc.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8CyJkC+azI8CWSO6+IzEj+TJNdIjke1BxCGff49wKV8=;
	b=Ky2XRdUWQRGdZB8QTJqeWS9jYe2I77sTBeiS2OLlgvsqgHd8+yJeWLUiklpLuI542B
	LWwpiZ4bX1+Zj2BJCTyvrTJNaWQuPheyXgbwXiO9kbpzsnGrL2fca7PGZyFxe894jzE7
	xaRjAGSR2l/W+1GK0+NLlg1g5+xjPgcNGXlTzo2EyI0cPTH1Hvp7CDfAuKtGcbGG+OgV
	YdBJqBZ4nT5cbOsgbUac/b5F6g4+kR0cU1gDOdy1GjRfTmF0JB8E6LiVuLc3hdTxH5Vm
	HYT7mt2s6/+34aD78DqjjuP6agtJkk03O6zWCioD61VtjaXMK0/IooBjjvy4D1VXR7RX
	7IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8CyJkC+azI8CWSO6+IzEj+TJNdIjke1BxCGff49wKV8=;
	b=ii0GMH+eDVGbh4QPFT11sY16g0kvEoyniDuEPjiCTE80FJLSM/dk+B10iskLZSCGSS
	7d1WjlwuygbJr231ag96cv9SLaEF726/kAu9+/flD/h1+qFAWV2H7nf9WIpOcRnQmuu9
	hLeYlshL/EGAoiLOW0r4mmpC7LJzEFBOD+w0wVVU4dgtwgc6DTnlWgOlP0ofnuDUKe56
	lFtmiZjUTCIGuBb03pOMttk4y5jRAinuPtDQoNNoeRJz7+2wu55ruShF7N5Jd8ULmUCl
	L33rhSAdpez87BKFV7K3ITcZXSVv7srC7j13tbJ7utM+8VWWpMa6/Y0iwmslIHjjU1Dt
	DxjQ==
X-Gm-Message-State: AG10YOQ+jtNOCB+xall94e8TBQ1MtZebiMa72NNl7WRjArh7yzuHXS9bO80ddpp4r0E7gw==
X-Received: by 10.182.125.129 with SMTP id mq1mr118918obb.7.1453941821481;
	Wed, 27 Jan 2016 16:43:41 -0800 (PST)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by smtp.gmail.com with ESMTPSA id h1sm4274956oek.11.2016.01.27.16.43.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 27 Jan 2016 16:43:40 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Jan 2016 16:43:17 -0800
Message-Id: <1453941798-11670-3-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
References: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
Subject: [PATCH 2/3] data.py: avoid double newlines at the end of functions in emit_var()
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
X-List-Received-Date: Thu, 28 Jan 2016 00:43:41 -0000

A newline is always appended to the function body when it's written
out, so strip any trailing newlines which may be there already.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index fac57da..70ba56b 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -227,6 +227,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
     if func:
         # NOTE: should probably check for unbalanced {} within the var
+        val = val.rstrip('\n')
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))
         return 1
 
-- 
1.9.1


