Return-Path: <openembedded-devel@urbanec.net>
X-Greylist: delayed 597 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 28 Jul 2015 06:10:11 UTC
Received: from mail15.tpgi.com.au (smtp-out15.tpgi.com.au [220.244.226.125])
	by mail.openembedded.org (Postfix) with ESMTP id E04BF761A2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 06:10:11 +0000 (UTC)
X-TPG-Junk-Status: Message not scanned
X-TPG-Antivirus: Passed
X-TPG-Abuse: host=60-242-171-118.static.tpgi.com.au; ip=60.242.171.118;
	date=Tue, 28 Jul 2015 15:47:21 +1000
Received: from gw.urbanec.net (60-242-171-118.static.tpgi.com.au
	[60.242.171.118])
	by mail15.tpgi.com.au (envelope-from openembedded-devel@urbanec.net)
	(8.14.3/8.14.3) with ESMTP id t6S5lIxQ001171
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 15:47:21 +1000
Received: from beep.urbanec.net ([192.168.42.2]) by gw.urbanec.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.85)
	(envelope-from <openembedded-devel@urbanec.net>)
	id 1ZJxjR-00053N-Gx; Tue, 28 Jul 2015 15:47:17 +1000
To: "Bystricky, Juro" <juro.bystricky@intel.com>,
	Christopher Larson <clarson@kergoth.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<CABcZANkHbT0R6HY5jtuCN+LLnJ2fVJV2nSVa5u_VCcTdzrct9w@mail.gmail.com>
	<6E51916E4A1F32428260031F4C7CD2B6101D2743@ORSMSX109.amr.corp.intel.com>
From: Peter Urbanec <openembedded-devel@urbanec.net>
Message-ID: <55B71765.6070901@urbanec.net>
Date: Tue, 28 Jul 2015 15:47:17 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6101D2743@ORSMSX109.amr.corp.intel.com>
Cc: "Purdie, Richard" <richard.purdie@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Tue, 28 Jul 2015 06:10:16 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I have not examined the code, but could the URL use the standard URL 
encoding mechanism to represent ; as %3B ?

The idea being that the initial "Bitbake URL" is parsed / split using 
the original string with semicolons and the URL escaped semicolon is 
passed through to a lower layer that uses that part of the string as an 
"Internet URL"

Cheers,
	Peter


On 28/07/15 02:10, Bystricky, Juro wrote:
> I agree that a generic solution is preferable. I also I think it is only
> prudent to support all valid URLs.
>
> The situation is complicated by the fact that at present it may not be
> possible to determine how to interpret the ‘;’ in SRC_URI.
>
> It can be part of the URL or it can be a SRC_URI delimiter/separator.
>
> As I don’t suppose changing the delimiter character from semi-colon to
> something else (i.e. an unsafe URL character)
>
> is an option, some other changes to the SRC_URI syntax are needed, for
> example:
>
> 1.Some form of escape sequence (i.e. ‘;;’ means treat as ‘;’) in URL, i.e.
>
> SRC_URI =
> "http://abc123.com/git/?p=gcc/gcc.git;;a=snapshot;;h=a5dd47;downloadfilename=abc.tar"
>
> 2.Quoted string implementation, using one of the “unsafe” URL characters
> such as ‘`’, to delimit  the URL
>
> SRC_URI = "’
> http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47`;downloadfilename=abc.tar"
>
> 3.Something else ?
>
> Thanks
>
> Juro
>
> *From:*kergoth@gmail.com [mailto:kergoth@gmail.com] *On Behalf Of
> *Christopher Larson
> *Sent:* Saturday, July 25, 2015 12:15 PM
> *To:* Bystricky, Juro
> *Cc:* bitbake-devel@lists.openembedded.org; Purdie, Richard
> *Subject:* Re: [bitbake-devel] [PATCH] wget.py: support for semi-colons
> in URL
>
> On Sat, Jul 25, 2015 at 11:32 AM, Juro Bystricky
> <juro.bystricky@intel.com <mailto:juro.bystricky@intel.com>> wrote:
>
>     Some URLs contain semi-colons. For example, some GIT repositories
>     support downloading snapshots using URL such as:
>
>     "http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
>
>     Currently there is no way to construct SRC_URI with such URLs.
>     Bitbake uses semi-colons in SRC_URI as delimiters for various
>     parameters.
>
>     This patch allows using of semi-colons in URLs: ';;' (double semi-colon)
>     in SRC_URI is processed  as a single semi-colon that is a part of a
>     URL name.
>     For example, the above URL would become:
>
>     SRC_URI = "http://abc123.com/git/?p=gcc/gcc.git;;a=snapshot;;h=a5dd47"
>
>     Note that it is not possible to determine the name of the downloaded
>     file
>     from URL alone. The onus to specify the proper name is on the user,
>     via the parameter 'downloadfilename':
>
>     SRC_URI =
>     "http://abc123.com/git/?p=gcc/gcc.git;;a=snapshot;;h=a5dd47;downloadfilename=myfile.tar.gz"
>
>     Signed-off-by: Juro Bystricky <juro.bystricky@intel.com
>     <mailto:juro.bystricky@intel.com>>
>
>
> In my opinion, if we’re going to support this, we should really support
> it in a generic way, in urldecode/urlencode & the URL class, and if
> needed leverage that in wget.
> --
>
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics
>
>
>


