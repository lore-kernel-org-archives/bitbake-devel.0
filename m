Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TjZZv-0007QL-MF for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 19:01:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBEHl6SG013902;
	Fri, 14 Dec 2012 17:47:06 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12514-08; Fri, 14 Dec 2012 17:47:02 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBEHkvQU013874
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Dec 2012 17:46:58 GMT
Message-ID: <1355507217.32519.33.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jon Szymaniak <jon.szymaniak@gmail.com>
Date: Fri, 14 Dec 2012 17:46:57 +0000
In-Reply-To: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
References: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: hg fetcher failures for SRCREV set to a tag
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
X-List-Received-Date: Fri, 14 Dec 2012 18:01:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-12-05 at 19:17 -0500, Jon Szymaniak wrote:
> tl;dr: Doesn't the "update" in lines 142-147 of hg.py cause issues when
> SRCREV is a tag?
> 
> 
> Hi all,
> 
> I didn't have any luck with this post on the Yocto mailing list. Since it seems
> more like a bitbake issue (I'm very hesitant to cry "bug" at this point),
> I hope I'm in the right place.
> 
> I've been running into "Fetcher failures" for my recipes using
> mercurial recently, which report that I'm asking for an unknown revision,
> despite it being valid. A trimmed log is at the end of this post.
> 
> After looking at hg.py, it seems the issue is that the
> 'hg update -r MY_TAG' that follows the 'hg clone -r MY_TAG ...' is doomed to
> fail because that tag isn't visible until the next rev, where the action of
> tagging it is committed.
> 
> For example, if I clone v1.1.0, I won't see that tag because the tag is added
> to .hgtags in commit 41:58b..
> 
>       tip                             41:58b8f368be68
>       v1.1.0                        40:a925b596c163
>       v1.0.4                        39:6bf84da2571e
> 
> Therefore once I've cloned with "-r v1.1.0", I can't do an update
> specifying tag v1.1.0.
> 
> Does this sound right, or am I way off here?
> 
> I'm not sure if using a tag rather than the revision number is unorthodox or
> abnormal for bb's, so below's my use case, for a my-app_0.1.2.bb
> 
> require my-app.inc
> PR = "${INC_PR}.0"
> SRCREV = "v${PV}"
> 
> Therefore to bring in a new version, I can simply copy this file to a
> my-app_1.1.0.bb, and adjust PR back to 0 if needed.
> 
> We have a policy not to move version tags, so tag-->revision should be 1:1. Is
> what I'm seeing a non-issue simply because one shouldn't use tags in SRCREV?
> 

FWIW, the hg fetcher is a little unloved. We don't have many developers
who use it or are familiar with how hg works. If there are some ways we
can fix things I'd be interested in patches.

I'm afraid I haven't had a chance to look at the details of the above
yet though.

Cheers,

Richard



