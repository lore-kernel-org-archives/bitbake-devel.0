Return-Path: <Maxin.John@enea.com>
Received: from mx-3.enea.com (sestofw01.enea.se [192.36.1.252])
	by mail.openembedded.org (Postfix) with SMTP id 5FD87606E8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 13:06:34 +0000 (UTC)
Received: from sestofb10.enea.se (172.21.3.145) by smtp.enea.com
	(172.21.1.209) with Microsoft SMTP Server id 14.3.224.2; Mon, 9 Feb 2015
	14:06:34 +0100
Received: by sestofb10.enea.se (Postfix, from userid 4454)	id 5D4F12800CB;
	Mon,  9 Feb 2015 14:06:34 +0100 (CET)
Date: Mon, 9 Feb 2015 14:06:34 +0100
From: "Maxin B. John" <maxin.john@enea.com>
To: Christopher Larson <clarson@kergoth.com>
Message-ID: <20150209130634.GA65302@sestofb10.enea.se>
References: <1423481849-5774-1-git-send-email-maxin.john@enea.com>
	<CABcZAN=GvNVLJgN=vWoor11rbBqYvg8EGPJt-okZyHs3+pvaEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZAN=GvNVLJgN=vWoor11rbBqYvg8EGPJt-okZyHs3+pvaEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: None (SESTOEX03.enea.se: maxin.john@enea.com does not
	designate permitted sender hosts)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] depexp.py: Fix segfault if DISPLAY is not set
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
X-List-Received-Date: Mon, 09 Feb 2015 13:06:40 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

On Mon, Feb 09, 2015 at 05:20:34AM -0700, Christopher Larson wrote:
> 
> On Mon, Feb 9, 2015 at 4:37 AM, Maxin B. John <maxin.john@enea.com> wrote:
> 
>     +    try:
>     +        gtk.init_check()
>     +    except:
>     +        print "Please set DISPLAY variable before running this command."
>     +        sys.exit(1)
>     +
> 
> 
> It's good that you're fixing this, but 1) this uses the old style non-function
> print, which isn't supported in new python, and 2) it outputs the error message
> to stdout rather than stderr, and 3) it looks like just returning rather than
> exiting is likely the best move.

Thank you very much for the review comments. I will update it as per
your suggestions and send the v2 soon.


> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics

Thanks and Regards,
Maxin

