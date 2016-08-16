Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 28802736B6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 13:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7GDkcaP022888; Tue, 16 Aug 2016 14:46:38 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1KddkjRFkGJE; Tue, 16 Aug 2016 14:46:38 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7GDkY5X022884
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Aug 2016 14:46:35 +0100
Message-ID: <1471355194.20391.108.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Tue, 16 Aug 2016 14:46:34 +0100
In-Reply-To: <CABcZANnCFXP4vS70_qitWWHru_RoC1uDzpKNU-Zy5D6JGhXxAQ@mail.gmail.com>
References: <1471280319.20391.93.camel@linuxfoundation.org>
	<CABcZANnCFXP4vS70_qitWWHru_RoC1uDzpKNU-Zy5D6JGhXxAQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Abstract worker functionality to an object/array
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
X-List-Received-Date: Tue, 16 Aug 2016 13:46:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-08-15 at 10:16 -0700, Christopher Larson wrote:
> 
> On Mon, Aug 15, 2016 at 9:58 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> > +                    if w in self.rq.worker:
> > +                        name = "Worker"
> > +                    elif w in self.rq.fakeworker:
> > +                        name = "Fakeroot"
> > 
> The concept seems sound, but there's still a fair bit of handling
> which is do this thing for workers and that thing for fake workers,
> makes me think we might want to split out objects to bind the
> workers, their names, and their logic.

I agree and there is certainly room for improvement. I think the patch
as it stands is probably a good first step and there are more that can
be made on top of it, I'm open to them or may get around to it myself
eventually if nobody else does. Part of the trouble I've had in doing
this is not to get distracted from the multi-config work which
necessitated it in the first place!

Cheers,

Richard



