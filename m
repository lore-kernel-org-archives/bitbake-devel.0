Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
	[209.85.216.41])
	by mail.openembedded.org (Postfix) with ESMTP id D49307FD93
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:54 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id m13so7970581pjb.2
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=xy9xzTnOJ6KkikHQxsJ1gzgU/Ey8fDAohwSAxet6Z9U=;
	b=okPeS7Gd6wuvyDYscmzUOixgY+uh139nIi1alxV3kC9iuf0eOrr6gJtxhz6Z4gIKIp
	UNlTA7yBVyIZcIfC/x/URrOJOqPSdQgd2FFegLLIJjgkElkPbxKyJaeCOuibYgzkAk7n
	jyKOrNQUXcRKMQa3VRBLzjLoJxFBeGC/5CeaJs3iz2NVygTx9BB2fuu15ajwKDfVP6W2
	8fe2cu1/0rBg2iUrmz1v4PYYVKYkr80KVTSJUM3XZKZUh6Tuq8U3vjlaFSSVSPeraSZA
	11CQggZNE7dqjIef9zEo15KbF8sefKdBtTyQqNL8GGK9Y8YvO4TdACUSzulBIRNtJ1+l
	bTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=xy9xzTnOJ6KkikHQxsJ1gzgU/Ey8fDAohwSAxet6Z9U=;
	b=Ndp8SdHBC8fEXyBl0gug1Aq+j/2yX8tVMJmDD4CQqBdaV84gTUA+G4uebLOznVGFaJ
	NzAksFYipPe46xGydzup9bT8EYT+FRHmWmScjddwyOlsi3vOEaAMIBXBZtYEnD1byTaD
	bOyqrk0cm7dc+34TWyjVpLGzd/2m9vCmRRKSq7E+oE5wIfwZVhSNoXrrbuio+mT7BCu7
	8dcJ6vkEhiuuRhoS4MSphXYngli0wx0shxNDSVaV9x/JnfELHHTcXsDk8YTAUjmKcRPT
	5tirSnGnkN6LN6pgGkDcp1CR8EekFo9U+iYssy74PmVLwTlVoUE4oEvJB6nPkeXgikok
	iG7A==
X-Gm-Message-State: APjAAAXScJV8seOfJQ1Be41Mj4nyOekVt/Kf/FlqebGflBPuHG5yCzls
	FgtSXCLgvgyqLOKNNke/w4PA4c6r
X-Google-Smtp-Source: APXvYqy+IhxH5q6uNikLSKL/wsukDMJvX2pu6aYvjMwtjEw3WyntIWjX7ksyoqNaeUPNZg0Co6r8dQ==
X-Received: by 2002:a17:902:7613:: with SMTP id
	k19mr32779993pll.7.1578328015532; 
	Mon, 06 Jan 2020 08:26:55 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.54
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:55 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:27 -0800
Message-Id: <0aee83e4e31dff7f4354e4eb4cbd35dd592e9f06.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 06/25] siggen: Ensure new unihash propagates through the system
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:55 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Its possible the new unihash may not exist in sstate. Currently the code
would create an sstate object with the old hash however this updates it to
create the object with the new unihash.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit abcaa1398031fa5338a43859c661e6d4a9ce863d)
---
 lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index de853268..dbf51023 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -513,6 +513,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                     self.set_unihash(tid, new_unihash)
+                    d.setVar('BB_UNIHASH', new_unihash)
                 else:
                     bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
             except hashserv.client.HashConnectionError as e:
-- 
2.17.1


