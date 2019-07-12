Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id 9C4747F105
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:13:53 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id n4so9969114wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=UBeJBS3p+Z/C/Mwa1v+13mvPV/Skap8e8Rma9uuEjVw=;
	b=Xa7V1IPVzP7ys29jcpoQ5dHnd+/B9inm0hSITHFMBqz12knEnOO3YzIgEmJCOptl4g
	cC0woEWLqRAFoQhcRkk/SUlPzzZDbvdV+0P4ksFOuLLQBS4l5RdcIF7zVo2EBIMS0Eog
	C2kjhWWH8eKygi0jDdCF8AMRfr/w9u2shNfRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UBeJBS3p+Z/C/Mwa1v+13mvPV/Skap8e8Rma9uuEjVw=;
	b=i0Klh3d0JwG3f8L3RtNNuOpN/WG0/CU/37z+lxQP8KvetgKNDK8siLc20GKFGrH9v6
	JGUscuRqH2P8sONBzLi1dykWTtN0t6khTMyA1rV0+2x6HO4WraVh5P7lDuNGcNUHNMU1
	T0jp9Y78R+IArgIrtxD89LNSA2KIu6CMREsN2CDdRIdIcv44aihL7/lXdka97syV1xn9
	jLTvJdCzBHDJtCvaxcMP1BYWNJDCsNkJEJK+PkFsrFsnhJFzDlpd5TdVO7TutKy/KcgU
	8XEr36Ss1LRAqf13YGgi7ugAdJOyIQ59EZKnl5ltrD3w/nSGsebhBrqY921i+I2JQMT8
	fjTQ==
X-Gm-Message-State: APjAAAWqd8bDa0Ok2r6aqOW0+wigxpQR+UiqEoK9+aTXDp9OqNC08b62
	7qaCLSccoIjohHIb7ttEbrKUof8lf2c=
X-Google-Smtp-Source: APXvYqwle1ID2OR2EEVbhuO95Oknbr1DAyPDwVgRJLGTyISO66IyHe+c5xpB7Aw9IqAOgGM4ArBL0Q==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr11372729wrw.276.1562937234055;
	Fri, 12 Jul 2019 06:13:54 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k9sm6015169wmi.33.2019.07.12.06.13.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 06:13:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 14:13:46 +0100
Message-Id: <20190712131349.29918-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
References: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/7] siggen: Use unique hashes for tasks
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
X-List-Received-Date: Fri, 12 Jul 2019 13:13:54 -0000
Content-Transfer-Encoding: 8bit

Now that runqueue optimises based on task hash, we need to ensure
tasks have unique hashes even in the simplest siggen mode. Use
the task name to calculate a unique hash.

This fixes runqueue tests when hash optimisations are added.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3b017219ed..f9c4798e3d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -49,8 +49,9 @@ class SignatureGenerator(object):
         return self.taskhash[task]
 
     def get_taskhash(self, fn, task, deps, dataCache):
-        self.taskhash[fn + "." + task] = "0"
-        return self.taskhash[fn + "." + task]
+        k = fn + "." + task
+        self.taskhash[k] = hashlib.sha256(k.encode("utf-8")).hexdigest()
+        return self.taskhash[k]
 
     def writeout_file_checksum_cache(self):
         """Write/update the file checksum cache onto disk"""
-- 
2.20.1


