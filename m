Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id 38B0B78E7A;
	Thu,  9 Aug 2018 22:10:54 +0000 (UTC)
Received: by mail-io0-f178.google.com with SMTP id m4-v6so5046658iop.3;
	Thu, 09 Aug 2018 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=HXWQFDI+QnDQsc8mkCnp7U5+nI7v5suZK+gcl+kQc1U=;
	b=Jn5S8ENL2wCGHM/eXSg4vleg6PXFr7IxliGFQQlEM05etpYzSalCkzuu15n/hPicmD
	0r851CqGGbGN60c3dfWtDlOg249RQIYqkavsVqwuK2nGDYP/cH5Wid/lGbCHCWROnvuC
	qoU2/QeglPTQmhyQ7k+ua4imvyec9Xx8sJjEJ3KiFHItewQGMkh4VXB10E1Jw0Jxj9Ng
	7205u+BWEr5r1JmspX/sS0IlCiqMldx7q37xziZR7/xzb1AltdwsAitozfN1NWNQQpUi
	WmQ0SwxGB+rm1wzX3IhOjBtjSVBqaH7Pl3CPlbV+o+CRv+EvTKaQbkK2ghNVITEx8gBM
	T4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=HXWQFDI+QnDQsc8mkCnp7U5+nI7v5suZK+gcl+kQc1U=;
	b=KYYJNW190XqiLcjJ1Q8O24Y253dnUPwSpld4yy4OprwrMo58aUbALnbxprXamoJYYs
	hf/BnC4BfewVG/dR+CyPo/Q1XWaDeyEIDtGkXxzCu5fnTzfuZ4K80oasqXU54tVrHbQ+
	7qTn1cfsfqGYOKBTo4jPgSikBG1w3hny3UKEM07HsNYL+6mvHEaa5O0PC09g5SB1a1ok
	kygxBVqb3IuJl0IrmuZPVPuiDKFRjt3ZL7ZGKbVmT5x+J1Kvn4CHkf+BSLQQYgCFscQU
	lBtCd6Zi19eIJ5jjGJT3EXP+dNlAy5+JrqhaiWRc0P0J185O64RyB6i95H7DbgcRLsLr
	pbWw==
X-Gm-Message-State: AOUpUlEJua2K09E/jor2IIcdOy9d0rDokXevvjh8xUFXKFzIxwOH2u+n
	XgrfryHj7F0MQ/Z6Ak8X8K6Mpemc
X-Google-Smtp-Source: AA+uWPz0Bky8aj8fFrXPvX0OXZHQ0T+F2tf/vcxnwEoaWe+PauFm0hSoej1rRn8Ib9+TXj11NOxKkA==
X-Received: by 2002:a6b:8e8f:: with SMTP id
	q137-v6mr3418733iod.174.1533852655298; 
	Thu, 09 Aug 2018 15:10:55 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:54 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:38 -0500
Message-Id: <20180809220840.26697-15-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 14/16] classes/sstate: Handle depid in hash check
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:54 -0000

Handles the argument that passes task dependency IDs in the hash check
function, as it is now required by bitbake

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 6743becf071..28a64315b60 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -766,7 +766,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=False):
 
     ret = []
     missed = []
-- 
2.17.1


