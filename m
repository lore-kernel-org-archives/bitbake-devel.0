Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C3F256E3DE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 08:58:50 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s318whGY010960; Tue, 1 Apr 2014 09:58:43 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TuGjWAGMX7rG; Tue,  1 Apr 2014 09:58:43 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s318waJQ010953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 09:58:38 +0100
Message-ID: <1396342711.14790.92.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: joe@deserted.net
Date: Tue, 01 Apr 2014 09:58:31 +0100
In-Reply-To: <1396298667-17975-1-git-send-email-joe@deserted.net>
References: <1396298667-17975-1-git-send-email-joe@deserted.net>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: parse: allow vars_from_file to consider inc files as recipes
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
X-List-Received-Date: Tue, 01 Apr 2014 08:58:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-03-31 at 16:44 -0400, joe@deserted.net wrote:
> From: Joe MacDonald <joe@deserted.net>
> 
> A side-effect of making vars_from_file return None for non-recipes is that
> PV gets 'None' if you have an included file named <recipe>.inc.  If there
> is a recipe with a version number in the name for a .inc file, it's
> probably reasonable to calculate PV based on that file, rather than giving
> it 'None' (which becomes 1.0 in most cases).
> 
> Signed-off-by: Joe MacDonald <joe@deserted.net>
> ---
>  bitbake/lib/bb/parse/__init__.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I ran into this when building meta-selinux where there's a chain of includes:
> 
>    refpolicy-mls_2.20130424.bb
>     -> refpolicy_2.20130424.inc
>       -> refpolicy_common.inc

The question to ask here is why is PV being expanded during the .inc
file?

When this code was changed, we did find some issues like this but it
usually means something unexpected was happening and "bad" PV values
were actually being used in some cases. It was therefore a conscious
decision not to do this.

If I take this change, you could get PV of "common" being used in the
second .inc file which is nasty.

I'd therefore much rather figure out what is happening to cause the
expansion of PV in the .inc file and see if we can't avoid that.

Looking at the layer, the issue is:

FILESEXTRAPATHS_prepend := "${THISDIR}/refpolicy-${PV}:"

and I'd suggest that line move to the .bb files in this case.

Cheers,

Richard




