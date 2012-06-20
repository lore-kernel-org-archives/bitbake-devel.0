Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShGbc-0006UX-3t for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 10:49:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5K8cmK0003106;
	Wed, 20 Jun 2012 09:38:48 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02848-02; Wed, 20 Jun 2012 09:38:44 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5K8cc8t003099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2012 09:38:40 +0100
Message-ID: <1340181520.1640.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Wed, 20 Jun 2012 09:38:40 +0100
In-Reply-To: <20120620075504.GB22538@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<dcf1fb0acb4bd3424cbb5f48cd62f4f994896c20.1340034255.git.paul.eggleton@linux.intel.com>
	<20120619193539.GA2530@giant> <4368013.N53ZsVQnoH@helios>
	<20120620075504.GB22538@giant>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q5K8cmK0003106
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: ensure -f causes dependent tasks to be re-run
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
X-List-Received-Date: Wed, 20 Jun 2012 08:49:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-20 at 09:55 +0200, Bj=C3=B6rn Stenberg wrote:
> Paul Eggleton wrote:
> > So my assumption is -f is most often used for the purpose of manually
> > forcing a recompile after you have made modifications to the already
> > extracted source code under the workdir.
>=20
> I agree with that.
>=20
> My concern is based on the fact that people (including myself) don't
> fully know all the details of how bitbake works, and tend to make
> assumptions based on other build systems they know, such as simple
> Makefiles.
>=20
> I think the fact that bitbake sometime works differently means we
> should be extra careful about not playing into devlelopers'
> assumptions. The bitbake option --force sounds rather similar to
> make's --always-make, especially when it is described as: "force run
> of specified cmd, regardless of stamp status". While a tangent, the
> --force parameter in standard unix utils like cp, mv, rm also matter.
>=20
> If we were to call it something different instead, like -t/--taint,
> this would avoid some assumptions about its behaviour and make it more
> clear that the output will be different even if the input is the same.
>=20
> Sure, it's not a major issue. But I'm fairly confident that if we keep
> the option name but change its behaviour, I am going to have to
> explain more than once to developers not following this list or the
> commit logs why -f does not do what they think (even though one can
> argue it never did). I'd rather they discover up front that -f is
> deprecated and that they should look up a new option instead.

We should be clear, its not a change in behaviour, its a bugfix for a
variety of nasty problems related to sstate. sstate needs to behave as
people would expect under a variety of circumstances and this change
only changes the interaction between sstate and the stamp files. This is
an area that is relatively new, we've found a nasty issue where sstate
files can become "corrupted" and we need to avoid that as it threatens
the integrity of the project.

I don't think renaming the option is a particularly good idea, that will
upset many user's fingers and mean we have to scrub the documents and in
itself will cause a ton of questions that need to be answered.

I would agree that the bitbake help text should be enhanced to make it
clear what this option does though. I do also think we need to raise
awareness of the change (which is why it was mentioned in yesterday's
meeting).

I appreciate we probably will get this question from time to time. We
(Yocto) are working on adding some kind of question/answer system (stack
overflow style) to the website btw, and this would make a good question
and answer on there! That would give us all a lightweight way to at
least answer the question.

Cheers,

Richard





