Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BD23A75264
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 09:12:17 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w949CDj5007389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 4 Oct 2018 10:12:15 +0100
Message-ID: <32e34671e86114fcff1d18ea5acfe610a2a049ac.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 04 Oct 2018 10:12:13 +0100
In-Reply-To: <20181003120346.3523-6-urs.fassler@bbv.ch>
References: <20181003120346.3523-1-urs.fassler@bbv.ch>
	<20181003120346.3523-6-urs.fassler@bbv.ch>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 5/7] fetch2/git: prevent access to non-existing clonedir
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
X-List-Received-Date: Thu, 04 Oct 2018 09:12:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2018-10-03 at 12:04 +0000, Urs Fässler wrote:
> A user friendly error is throw when neither the clonedir nor
> fullshallow exist. Without the check, a difficult to interpret error
> is throw from within the fetch command.
> 
> Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
> Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
> ---
>  lib/bb/fetch2/git.py  |  4 +++-
>  lib/bb/tests/fetch.py | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index f13a25f9..fbd30011 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -479,8 +479,10 @@ class Git(FetchMethod):
>          if ud.shallow and os.path.exists(ud.fullshallow) and self.clonedir_need_update(ud, d):
>              bb.utils.mkdirhier(destdir)
>              runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
> -        else:
> +        elif not self.clonedir_need_update(ud, d):
>              runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
> +        else:
> +            bb.fatal("no up to date source found")

I appreciate there are other places the fetcher code calls bb.fatal()
but this is problematic.

The intent is to make the fetcher code a library which other code call
call into and this is already how OE treats it. Python libraries should
raise exceptions on errors and allow the parent code to handle it, not
raise SystemExit() exceptions.

Is there some other way we can raise a decent error even if means
adding a new exception (which can subclass one of the other fetch
exceptions)?

Cheers,

Richard

