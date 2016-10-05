Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5F13571A73;
	Wed,  5 Oct 2016 14:44:39 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u95EieGQ018912
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 5 Oct 2016 07:44:40 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 5 Oct 2016 07:44:39 -0700
To: Jeff Hatch <jhatch@multitech.com>
References: <1475675870.8940.167.camel@hatchville>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <6f6867da-29f4-545f-2484-763584667738@windriver.com>
Date: Wed, 5 Oct 2016 09:44:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1475675870.8940.167.camel@hatchville>
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: Not building python socketmodule.c with openssl 1.0.2h
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
X-List-Received-Date: Wed, 05 Oct 2016 14:44:40 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 10/5/16 8:57 AM, Jeff Hatch wrote:
> I am seeing an issue where we upgraded the openssl bitbake recipes to build and
> install openssl 1.0.2h in a higher layer than the base openembedded layer which
> was building openssl 1.0.1m.  After this was done, the build of python 2.7.3
> stopped building the socketmodule.c and ssl was not integrated into python.  For
> example, the httplib object no longer has a reference for the HTTPSConnection
> object.  I have spent some time digging around and cannot find anything that
> makes sense as to why this is happening.  Is there anyone that has enough Python
> knowledge to know what might be causing this, or has run into this already and
> fixed it?
> 
> We are a little behind on Yocto (Daisy), but I don't know that that should be a
> problem. 

This question should go to the "openembedded-core@lists.openembedded.org"
mailing list, or a list specific to the layers.  (I have CC'd this list.)

Unfortunately I am not surprised by this.  Daisy is quite old at this point.  It
was released in April of 2014.  OpenSSL 1.0.2 was not released until January
2015.  I doubt that the system, nor python 2.7.3 (as integrated) has any idea
that version 1.0.2 exists.

You will likely need to look at backporting support from a newer version of
python to support the 1.0.2 API.

--Mark

> Thank You,
> 
> -- 
> Jeff Hatch
> Senior Software Engineer
> 
> 
> 1 (763) 717 - 5574   DIRECT
> 1 (763) 228 - 3603   MOBILE
> 
> 2205 Woodale Drive 
> Mounds View, MN 55112
> 
> www.multitech.com <http://www.multitech.com/>
> 
> 
> 
> 
> 


