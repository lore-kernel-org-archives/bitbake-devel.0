Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RR2eb-0003Ps-Tu for bitbake-devel@lists.openembedded.org;
	Thu, 17 Nov 2011 15:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAHE2xH7017449
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Nov 2011 14:02:59 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16264-08 for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Nov 2011 14:02:55 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAHE2ofi017443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Nov 2011 14:02:51 GMT
Message-ID: <1321538575.27449.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Nov 2011 14:02:55 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [Fwd: [OE-core] [PATCH] siggen.py: Include list of variables in hashes]
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 17 Nov 2011 14:09:26 -0000
X-Groupsio-MsgNum: 626
Content-Type: multipart/mixed; boundary="=-dB8BVIkd7T5pcwQHpFC1"

--=-dB8BVIkd7T5pcwQHpFC1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-dB8BVIkd7T5pcwQHpFC1
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [OE-core]
 [PATCH] siggen.py: Include list of variables in hashes
Content-Type: message/rfc822

Return-Path: <openembedded-core-bounces@lists.openembedded.org>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on tim.rpsys.net
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0
 tests=AWL,BAYES_00,FH_DATE_PAST_20XX, RDNS_NONE autolearn=no version=3.2.5
Received: from localhost (localhost [127.0.0.1]) by tim.rpsys.net
 (8.13.6/8.13.8) with ESMTP id pAHE1iJ5017403 for <richard@[127.0.0.1]>;
 Thu, 17 Nov 2011 14:01:44 GMT
Received: from tim.rpsys.net ([127.0.0.1]) by localhost (tim.rpsys.net
 [127.0.0.1]) (amavisd-new, port 10024) with LMTP id 16264-07 for
 <richard@[127.0.0.1]>; Thu, 17 Nov 2011 14:01:40 +0000 (GMT)
Received: from tim.rpsys.net (IDENT:1000@localhost [127.0.0.1]) by
 tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAHE1bMs017396 for
 <richard@localhost>; Thu, 17 Nov 2011 14:01:37 GMT
MIME-Version: 1.0
Received: from 192.168.3.10 [192.168.3.10] by tim.rpsys.net with IMAP
 (fetchmail-6.3.2) for <richard@localhost> (single-drop); Thu, 17 Nov 2011
 14:01:37 +0000 (GMT)
Received: from orsmsx602.amr.corp.intel.com (10.22.226.211) by
 irsmsx151.ger.corp.intel.com (163.33.192.59) with Microsoft SMTP Server
 (TLS) id 14.1.355.2; Thu, 17 Nov 2011 14:01:27 +0000
Received: from orsmga001.jf.intel.com (10.7.209.18) by
 orsmsx602-1.jf.intel.com (10.22.226.211) with Microsoft SMTP Server id
 8.2.255.0; Thu, 17 Nov 2011 06:01:25 -0800
Received: from orsmga101.jf.intel.com ([10.7.208.22])  by
 orsmga001-1.jf.intel.com with ESMTP; 17 Nov 2011 06:01:25 -0800
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: 
 Aj4BAMUSxU6M06kMmWdsb2JhbABCqX4iAQEBAQEICwsHFCWBdAYBATcMCh4OAwECBgJABAQIAwEjATUTBYd/BrU9g1mGPgSSFodajEE
X-IronPort-AV: E=Sophos;i="4.69,527,1315206000";  d="scan'208";a="423907864"
Received: from mail.linuxfoundation.org ([140.211.169.12])  by
 mga02.intel.com with ESMTP; 17 Nov 2011 06:01:25 -0800
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
 [172.17.192.36])	by mail.linuxfoundation.org (Postfix) with ESMTP id
 46FB042B for <richard.purdie@linuxfoundation.org>; Thu, 17 Nov 2011
 13:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from linuxtogo.org (linuxtogo.org [188.40.83.200])	by
 smtp2.linuxfoundation.org (Postfix) with ESMTPS id 602091DADD	for
 <richard.purdie@linuxfoundation.org>; Thu, 17 Nov 2011 13:59:51 +0000 (UTC)
Received: from localhost ([127.0.0.1])	by linuxtogo.org with esmtp (Exim
 4.72) (envelope-from <openembedded-core-bounces@lists.openembedded.org>)	id
 1RR2cq-0003L0-H8; Thu, 17 Nov 2011 15:07:36 +0100
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
 helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)	(envelope-from
 <richard.purdie@linuxfoundation.org>)	id 1RR2co-0003Kn-Cl for
 openembedded-core@lists.openembedded.org;	Thu, 17 Nov 2011 15:07:34 +0100
Received: from localhost (localhost [127.0.0.1])	by tim.rpsys.net
 (8.13.6/8.13.8) with ESMTP id pAHE1977017389	for
 <openembedded-core@lists.openembedded.org>;	Thu, 17 Nov 2011 14:01:09 GMT
Received: from tim.rpsys.net ([127.0.0.1])	by localhost (tim.rpsys.net
 [127.0.0.1]) (amavisd-new,	port 10024) with LMTP	id 15957-08 for
 <openembedded-core@lists.openembedded.org>;	Thu, 17 Nov 2011 14:01:03 +0000
 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)	by
 tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAHE11Bg017383
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for
 <openembedded-core@lists.openembedded.org>;	Thu, 17 Nov 2011 14:01:02 GMT
Message-ID: <1321538466.27449.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-core <openembedded-core@lists.openembedded.org>
Date: Thu, 17 Nov 2011 14:01:06 +0000
X-Mailer: Evolution 3.2.1- 
Subject: [OE-core] [PATCH] siggen.py: Include list of variables in hashes
X-BeenThere: openembedded-core@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
List-Id: Patches and discussions about the oe-core layer
 <openembedded-core.lists.openembedded.org>
List-Unsubscribe: 
 <http://lists.linuxtogo.org/cgi-bin/mailman/options/openembedded-core>,
 <mailto:openembedded-core-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/openembedded-core>
List-Post: <mailto:openembedded-core@lists.openembedded.org>
List-Help: 
 <mailto:openembedded-core-request@lists.openembedded.org?subject=help>
List-Subscribe: 
 <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core>,
 <mailto:openembedded-core-request@lists.openembedded.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: <openembedded-core-bounces@lists.openembedded.org>
Errors-To: openembedded-core-bounces@lists.openembedded.org
X-MS-Exchange-Organization-AVStamp-Mailbox: NAI;54066478;0;novirus
X-MS-Exchange-Organization-AuthSource: orsmsx602.amr.corp.intel.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-Virus-Scanned: amavisd-new at rpsys.net
Content-Transfer-Encoding: 7bit

Ensure that the list of dependencies is included in the hash
as well as their contents

Prior to this, adding or removing dependencies with values
of "None" would not change the hash, despite diffsigs reporting
this difference.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 1225791..4ccfc7d 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -101,6 +101,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             alldeps = seen - self.basewhitelist
 
             for dep in sorted(alldeps):
+                data = data + dep
                 if dep in lookupcache:
                     var = lookupcache[dep]
                 else:



_______________________________________________
Openembedded-core mailing list
Openembedded-core@lists.openembedded.org
http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core


--=-dB8BVIkd7T5pcwQHpFC1--
