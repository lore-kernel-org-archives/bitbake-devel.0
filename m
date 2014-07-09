Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9058470495
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 21:39:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s69LclZZ021317; Wed, 9 Jul 2014 22:38:47 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4vbU-5n2eYFh; Wed,  9 Jul 2014 22:38:46 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s69Lch9f021310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 9 Jul 2014 22:38:45 +0100
Message-ID: <1404941917.15985.63.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 09 Jul 2014 22:38:37 +0100
In-Reply-To: <alpine.LFD.2.11.1407091107010.10307@localhost>
References: <alpine.LFD.2.11.1407091107010.10307@localhost>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: possible clarification of EXPORT_FUNCTIONS for user manual
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
X-List-Received-Date: Wed, 09 Jul 2014 21:39:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-07-09 at 11:14 -0400, Robert P. J. Day wrote:
>   so, just to make sure i'm understanding this correctly, in section
> 3.4.5 of BB user manual, discussion of EXPORT_FUNCTIONS talks about
> the general concept of exporting *functions*, but the entire section
> uses exclusively "do_" examples, which might mislead the reader into
> thinking it's good only for *tasks*.
> 
>   i decided to look through the oe-core layer for examples of
> exporting an actual function, and i found all of one example -- in
> meta/classes/debian.bbclass:
> 
>   python debian_package_name_hook () {
>       ... snip ...
>   }
>   ...
>   EXPORT_FUNCTIONS package_name_hook
> 
> which seems like a valid example of exporting a function, except i
> can't find a single example of this function being used anywhere else.
> am i missing something?
> 
>   anyway, i guess my point is that that section could be tweaked to
> emphasize that exporting works for both functions and tasks, although
> the only function example i found seems unused. thoughts?

package_name_hook is called by package.bbclass

Cheers,

Richard


