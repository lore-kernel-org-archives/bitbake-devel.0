Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id 013EC7F319
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:04:20 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id b16so829926wrq.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=9zB6UhpcshjwGCGzTSVdHks2E3tB4fJYfSa4iGpd7lw=;
	b=LC8utb5sdrsaKbJNQwE8TNmKa1FcicEngQZqsIr0EWapY0X4iU7GoaCZc48WhhU9zS
	waENJQ1Hi2SALFfS8ZnFwHuUov6x7xO2gqG6Tfb9Aucxifb5ZrUUlsEb3418UyeQ7txV
	Jk422tEFaKDda1O8zzRJU9dGl/YKvZB/jHiFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9zB6UhpcshjwGCGzTSVdHks2E3tB4fJYfSa4iGpd7lw=;
	b=Rd7TWlOlIW6D81OFRfH3SK/MA/XwgDm6NatZJnlLDtp9hPosCRdmHAZvX+NDujNHP4
	g+RGOSE4qVXflwpKArFfrIyOuXEabRjFqvZkg4i+EAqxQXcBefslCMvQgA4XqeU7Lpmq
	PKEcoADKhCssZ25/m3CBqwPhsGuouj18Kjw8cs3IgHcL0O5O4b+kWm2T7zDleLYBYsDq
	qdK5+QuRxPDom2zHvNwqKDKakjkgLWk2ataQR71JCtMWH/0KtPfYEq5dUJxPPU1uOKQU
	orG94j/3OjW91DhB6/LHXJckxUBYvNU9DGjMCGByN61Ub7Ls61f6s1fnlLAJ8Of25/W2
	39rw==
X-Gm-Message-State: APjAAAUv3dAChIUEI7gVUyqG43vO7TPrsAw6DAjXzKPB4awwHG1XcQ8L
	DzLS/5qKYYrV7GNraK0jNoAw1RQPPCK/Eg==
X-Google-Smtp-Source: APXvYqzoUfwLIo4mK+QEY8lVh0tJY7RJkNFL4di7wb/mTH9nP5bVNfPN9NxLuxaMDmKdWtLIBomSDw==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr9531774wrs.36.1565946261354; 
	Fri, 16 Aug 2019 02:04:21 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x6sm3347793wmf.6.2019.08.16.02.04.20
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 02:04:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 10:04:18 +0100
Message-Id: <20190816090418.13807-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816090418.13807-1-richard.purdie@linuxfoundation.org>
References: <20190816090418.13807-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/2] runqueue: Ensure target_tids is filtered
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
X-List-Received-Date: Fri, 16 Aug 2019 09:04:21 -0000
Content-Transfer-Encoding: 8bit

bitbake <target> --runonly=fetch

failed as the target_tids list included entries which were no longer targeted
task ids. Fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4e64ddfdad..7fa074f679 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1736,6 +1736,7 @@ class RunQueueExecute:
         # We can't skip specified target tasks which aren't setscene tasks
         self.cantskip = set(self.rqdata.target_tids)
         self.cantskip.difference_update(self.rqdata.runq_setscene_tids)
+        self.cantskip.intersection_update(self.rqdata.runtaskentries)
 
         schedulers = self.get_schedulers()
         for scheduler in schedulers:
-- 
2.20.1


