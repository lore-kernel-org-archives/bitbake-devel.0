Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 530526010B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tAJCwN3f023804; Thu, 19 Nov 2015 12:58:23 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1e5uMtBUzZ-5; Thu, 19 Nov 2015 12:58:23 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tAJCw9k0023798
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Nov 2015 12:58:21 GMT
Message-ID: <1447937889.12500.134.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Wood <michael.g.wood@intel.com>
Date: Thu, 19 Nov 2015 12:58:09 +0000
In-Reply-To: <564DC36B.3030900@intel.com>
References: <564DC36B.3030900@intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Release and versions
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
X-List-Received-Date: Thu, 19 Nov 2015 12:58:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-11-19 at 12:41 +0000, Michael Wood wrote:
> We're currently manually maintaining a file[1] that maps metadata 
> release names e.g. 'fido' to the corresponding Bitbake version in 
> 'toasterconf'. This is time consuming and confusing for people who are 
> running Bitbake/Toaster or Poky to work out which toasterconf is suited 
> for their setup.
> 
> Currently the only real need for these files is to know which Bitbake 
> versions are supported with which metadata versions, without someone 
> reading https://wiki.yoctoproject.org/wiki/Releases and editing a file 
> and submitting it. Would it make sense to make Bitbake versions match 
> those of it's metadata?
> If departing from the current numbering scheme wouldn't be welcomed, 
> would there be room for a compromise where the Bitbake versions also 
> contain the release name e.g. 1.26_fido?

At least in principle, OpenEmbeddedded is one possible metadata
implementation which uses bitbake as its core tool. There is a pretty
strong abstraction of "task execution" from the metadata.

Bitbake isn't tied to the OpenEmbedded release cycles although we do
tend just to release it at those points so there is a stable branch to
use for the release series. We've saved "bitbake 2.0" for some other
time for example compared to Yocto Project 2.0 so the version numbers
are out of sync and always have been. I'm resistant to just making
everything follow each other since whilst they do happen to have the
same maintainer and release cycles at present, it could change in the
future.

Obviously toaster is quite a weird hybrid part since its much more tied
to OpenEmbedded than bitbake itself is, but its also tied to bitbake
too.

I'd also worry about toaster if toaster makes what is an adopted
convention a hard requirement since in product environments, I doubt
mappings will be this simple.

Its not the first time I've heard the request and I do understand the
confusion it causes, equally, I do think people should understand the
different project components do have version numbers and release cycles
and that there are different components.

FWIW I think 1.26_fido is pretty ugly and don't like it at all. The
compromise is probably to create 1.26 and fido branches and just have
them track each other. That pushes the problem from the toaster people
onto me instead. Branches are cheap in git thankfully.

Cheers,

Richard



