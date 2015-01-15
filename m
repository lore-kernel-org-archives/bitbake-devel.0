Return-Path: <gary@mlbassoc.com>
X-Greylist: delayed 428 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 15 Jan 2015 18:29:35 UTC
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id C79D471144
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 18:29:35 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id A86E8F811DF; Thu, 15 Jan 2015 11:22:27 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=4.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 5B9BEF811DE;
	Thu, 15 Jan 2015 11:22:27 -0700 (MST)
Message-ID: <54B80569.5030507@mlbassoc.com>
Date: Thu, 15 Jan 2015 11:22:33 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Parsing recipes progress bar doesn't show incremental progress
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
X-List-Received-Date: Thu, 15 Jan 2015 18:29:46 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I think there has been a recent change in behaviour.  When
you start up bitbake there is a progress bar during the recipe
parsing:
   Parsing recipes: 100% |##########################################| Time: 00:00:05

I used to see this bar fill as it went, but now it sits there
at 0% until it is completely done and then BAM goes to 100%

Has anyone else seen this?  I'm running Poky/Yocto updated
to 2b925045877aeb44d9823a8c9515e8ab8fca1e52 as of 2015-01-15

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

