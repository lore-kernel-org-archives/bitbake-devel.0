Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F228C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 20:20:54 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.2238.1633638053188730604
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 13:20:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OXnSdU/8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id r10so22723802wra.12
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWvDZrV4I75SgrxcsIBhYNGaPbwyh6TLZ02jcUJnUFs=;
        b=OXnSdU/8go2hiQ35T7Ub19XtSK0kXWPMZedjcVDHJxCVL/4yMFDt59vfzHbW2Jt+zJ
         c3NODksJo0chtD3L6n3OR/y1oOrkWnHB+7Y3+5CvYSag+6cgGcesGihxq2/DSY8igonw
         XEM77T2YkKoPoiOzRBk6Y4uVTx0B3vOyXi6K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWvDZrV4I75SgrxcsIBhYNGaPbwyh6TLZ02jcUJnUFs=;
        b=beUMn3pou0tQ7bREMhpkXBbRFE9mf/o+91zEd087LQaeWQVN6oyfsq/sUKuxj9Hjx4
         Ok5b9lFkjOCWTSbbfxeKcmn5XYjKTQeDR5k803DakVvzCc5Opez/kKzg2vghP5SonZiN
         r4PDGSfryf5Sw+q2H0CYm8/ciHePxOkYp01bhgTN4sq89kTHXQUup9tPXG6fU33lnN+K
         rO4Xh18nRH9xxoIEDdeMet4tli335waH7iSqU9AQWilxcl++9kPjOC1XhYrRT4iFfmuS
         HdGYGTq6+iaS1d+izuwBWrGoDFME0WQWM2E0VZXbN71RHbacSmg+nt/b5e9m7sUWn9ed
         fatg==
X-Gm-Message-State: AOAM53255OOZtvinC6rgE8bdanFp0qPsDAx60axxJ3XympzqE/o+CSs6
	PWErNO4FdOdpvQwn99OF+qt5pTahgcfwHg==
X-Google-Smtp-Source: 
 ABdhPJzNAqxxiayDUhJyMJ3UjPQ4yehGskLjpc6ZIHFIary4mYmI9zgyhVjdi8HenhUxhx4F2QkNhQ==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr18402718wmj.103.1633638051455;
        Thu, 07 Oct 2021 13:20:51 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5719:ccd0:9969:333f])
        by smtp.gmail.com with ESMTPSA id
 f16sm349099wrr.53.2021.10.07.13.20.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:20:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Work around unihash issues
Date: Thu,  7 Oct 2021 21:20:50 +0100
Message-Id: <20211007202050.2431986-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 20:20:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12753

Currently we have a bit of a determinism issue with hashequiv since there
can be a unihash assigned by the server between our original query and
this code reporting the outhash. This is fine if the outhashes are the same
but if the outhashes are different (a determinism issue or a different
arch situation). If the outhashes do differ, build can then proceed in a
different path than a later build doing fresh unihash lookups would proceed
in.

There are changes on the server side we could make to try and address
this but those are invasive this close to release. For now, requery the
server and update the unihash. This should avoid the determinism issues
and match the behaviour some future server changes will have in a way that
is a reasonable workaround for this release.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 625a9cf3bb..f6694e884b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -612,8 +612,14 @@ class SignatureGeneratorUniHashMixIn(object):
                     method = method + self.extramethod[tid]
 
                 data = self.client().report_unihash(taskhash, method, outhash, unihash, extra_data)
+
                 new_unihash = data['unihash']
 
+                # Check we get the correct unihash back and fixup if not
+                data = self.client().get_unihash(method, taskhash)
+                if data:
+                    new_unihash = data
+
                 if new_unihash != unihash:
                     hashequiv_logger.debug('Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
-- 
2.32.0


