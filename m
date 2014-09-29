Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F26D96017E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Sep 2014 16:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8TGsrUt009395; Mon, 29 Sep 2014 17:54:53 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Dc19NJMF4eXl; Mon, 29 Sep 2014 17:54:53 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8TGsmLf009391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 29 Sep 2014 17:54:49 +0100
Message-ID: <1412009721.6893.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ben Shelton <ben.shelton@ni.com>
Date: Mon, 29 Sep 2014 17:55:21 +0100
In-Reply-To: <20140926220153.GA29668@bshelton-desktop>
References: <20140926220153.GA29668@bshelton-desktop>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Getting bitbake_prserv database contents to persist across power loss
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
X-List-Received-Date: Mon, 29 Sep 2014 16:55:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2014-09-26 at 17:01 -0500, Ben Shelton wrote:
> Hi all,
> 
> We're currently running a shared PR server that is used by all the
> OpenEmbedded build machines on our intranet (both for developers'
> machines and for nightly build machines).
> 
> We recently ran into an issue where the blade that the shared PR server
> runs on was shut down unexpectedly and the PR history since the PR
> server was last restarted was not committed to disk.  Looking at the
> commit 'prserv: Ensure data is committed', it looks like the only times
> the transactions are committed is when the PR server process is shut
> down.
> 
> What would be your guidance in this case?  Should we just shut down /
> restart the PR server nightly to save off the data?  If we wrote a patch
> to the PR server to commit the data to the database at runtime-specified
> intervals, would that be something we could upstream?

I've had a few people mention this and I would accept a patch, as long
as it doesn't blindly sync to disk every interval but instead keeps some
notion of "dirty" or not in the server. The sync calls filtering through
the various IO layers can be painful if they happen too often.

Cheers,

Richard


