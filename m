Return-Path: <mcfrisk@kapsi.fi>
X-Greylist: delayed 2067 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 16 Sep 2019 07:50:01 UTC
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	by mail.openembedded.org (Postfix) with ESMTP id 086917ED7E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2019 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UTc+tMI9b4H31AcSq2NHHlQa1QbO/Jkm7LldiG2CkmY=;
	b=DE+fA8sRSaDNPJXSQkPncCnBua
	SZcImBFNcPivNX6Bhn94q3jal0sHfeNu8TkDG2jXOgF9klK/gA1dkQKs/VucpD1e+w7VqiHyK0Io+
	hny+yi8CCG89ZgN+KOtwAmDIK+Dh/nxgsk/8dn0GQ597vDzPiN6Rzpx8H1FVau6TZr9QImhioCv0f
	fvB8p5M4JfNW0aKW5NJPVV1I33CkPFgXM/mPMU2RGjmOG2Z1eeab6UG/BYl99o+ndPZcKNZC+wifu
	XvrTDbi3df3dO6qNWy0Lv/ScWw7Dnvx4QrfLtBd3vizRuIEHiq/gG3ZINPP8EO38VQDugMpHZMGzz
	Q9oq8buw==;
Received: from kapsi.fi ([91.232.154.11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.89) (envelope-from <mcfrisk@kapsi.fi>)
	id 1i9lET-0000qs-FP; Mon, 16 Sep 2019 10:15:33 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1i9lE2-0003Uc-T0; Mon, 16 Sep 2019 10:15:06 +0300
From: Mikko Rapeli <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2019 10:14:50 +0300
Message-Id: <1568618090-6633-1-git-send-email-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.1.4
X-Rspam-Score: 1.2 (+)
X-Rspam-Report: Action: no action Symbol: ARC_NA(0.00)
	Symbol: DMARC_POLICY_SOFTFAIL(0.10) Symbol: R_SPF_NEUTRAL(0.00)
	Symbol: FROM_HAS_DN(0.00) Symbol: TO_DN_SOME(0.00)
	Symbol: TO_MATCH_ENVRCPT_ALL(0.00) Symbol: MIME_GOOD(-0.10)
	Symbol: RCVD_TLS_LAST(0.00) Symbol: NEURAL_SPAM(0.00)
	Symbol: IP_SCORE(-0.10) Symbol: RCPT_COUNT_TWO(0.00)
	Symbol: MID_CONTAINS_FROM(1.00) Symbol: FORGED_SENDER(0.30)
	Symbol: R_DKIM_NA(0.00) Symbol: MIME_TRACE(0.00)
	Symbol: ASN(0.00) Symbol: FROM_NEQ_ENVFROM(0.00)
	Symbol: RCVD_COUNT_TWO(0.00) Message: (SPF): spf neutral
	Message-ID: 1568618090-6633-1-git-send-email-mikko.rapeli@bmw.de
X-Rspam-Bar: +
X-SA-Exim-Connect-IP: 91.232.154.11
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Subject: [PATCH 2/2] svn fetcher: allow "svn propget svn:externals" to fail
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
X-List-Received-Date: Mon, 16 Sep 2019 07:50:02 -0000

Not all servers and repositories have this property set
which results in failures like this when actual svn checkout
command succeeded:

svn: warning: W200017: Property 'svn:externals' not found on ''
svn: E200000: A problem occurred; see other errors for details

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/fetch2/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 59ce931..96d666b 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -145,7 +145,7 @@ class Svn(FetchMethod):
 
             if not ("externals" in ud.parm and ud.parm["externals"] == "nowarn"):
                 # Warn the user if this had externals (won't catch them all)
-                output = runfetchcmd("svn propget svn:externals", d, workdir=ud.moddir)
+                output = runfetchcmd("svn propget svn:externals || true", d, workdir=ud.moddir)
                 if output:
                     if "--ignore-externals" in svnfetchcmd.split():
                         bb.warn("%s contains svn:externals." % ud.url)
-- 
1.9.1


