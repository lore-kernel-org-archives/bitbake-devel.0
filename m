Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1lhg-0001uj-Ep for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 00:04:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FLqhXB005853;
	Wed, 15 Aug 2012 22:52:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05770-01; Wed, 15 Aug 2012 22:52:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FLqaZU005847
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 Aug 2012 22:52:37 +0100
Message-ID: <1345067556.14667.34.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 15 Aug 2012 22:52:36 +0100
In-Reply-To: <CABcZANmPSnoyQ4PDcEsE=4EErgpNekAG919Bj+-vFwqAq0BCmA@mail.gmail.com>
References: <1345049422.14667.11.camel@ted>
	<CABcZANmPSnoyQ4PDcEsE=4EErgpNekAG919Bj+-vFwqAq0BCmA@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q7FLqhXB005853
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] knotty: Fold knotty2 into knotty and make it the default
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
X-List-Received-Date: Wed, 15 Aug 2012 22:04:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-15 at 12:20 -0700, Chris Larson wrote:
> On Wed, Aug 15, 2012 at 9:50 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > There is no good reason knotty2 shouldn't be the default now. If you =
need
> > the old behaviour, just pipe the output through cat as non-interactiv=
e
> > terminals get the old output.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> I'm 100% in favor of this series, for what it's worth. I've been using
> knotty2 as my default BITBAKE_UI for months, just ignoring the minor
> bugs. The reduction in unnecessary output makes it *much* easier to
> spot *real* problems.

Agreed, that is one of the intents.

> That said, I think we should look into prefixing some of our log
> messages =E2=80=94 some of them don't make it clear what task/recipe em=
itted
> them, making it difficult to isolate their cause. But of course, that
> was an issue with knotty as well, but it was slightly easier to narrow
> down the cause based on where it stood between the task
> started/completed messages :). Would you be open to potentially
> injecting a log message filter which adds task context informastion,
> in the code which forks the tasks? Then the formatter would have to do
> a hasattr() to check for that and add it to the format, but it'd mean
> we *always* know what task log messages are coming from.

Obviously such a change needs to be carefully considered but yes, I
think knowing where a message has come from is important and I'm in
favour of doing something. I'm slightly surprised there isn't something
in the message already.

Thinking about this more, I think we did add in the pid or at least
looked at doing so, with the assumption that the UI code could have
information about what that pid represents and be able to supplement the
data. I think the graphical UIs might use that to put the messages into
different "buckets" in the graphical task display.

The immediate reaction is "lets just add all the data to the event"
which I can certainly understand. My big worry is the pushing up the
size of each event to something that damages performance, particularly
if we so start using remote UIs. This is why the uihelper code exists,
effectively to maintain a UI side cache of the data rather than
pickle/unpickling the same thing many times.

As a side note, I do want to get handlers only receiving the events they
care about with server side filtering too. That is starting to show up
on profiles of some workloads.

Also, we currently use the word "package" in the old knotty output, I
want to change that to "recipe" as its confusing and we should be
consistent about our terminology. I guess I should propose a patch :)

Cheers,

Richard






