Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id 2A2C87F586
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 08:25:15 +0000 (UTC)
IronPort-SDR: nXRR1W1aDtcLvmA14FMXyH8Km3JOZsj2NJsnWJ/WAD9yWsnPdWTysm4y3KJ7CKRPiUGbEEM1+X
	bZqobsseMb7OVMFuD/3/Ltu8OHqmSx5HZFDAocpiSwqBwpteVmQcZssPLkgV+UGNSk3qYMZZZN
	JEyaU/SIGEABr4dlxU5hi7pt9LQFgDNs98YMtavgBVn4C3nMHFrWKIMWJHirsG9eQoTG0vRHBR
	Koqg6MJhDL2NwdOojJsqSbJE1MLLFs3I+x37+VIlvlndCRqeROQfoldQJRbvuwGlAHHT0yMOfr
	Erk=
X-IronPort-AV: E=Sophos;i="5.69,346,1571695200"; 
   d="scan'208";a="3848783"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Armin Kuster <akuster808@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [1.44 02/18] runqueue/siggen: Allow handling of
	equivalent hashes
Thread-Index: AQHVuUyfrv2Gsdgmzk2Wby/mHNtUcKfHXkkg
Date: Mon, 23 Dec 2019 08:25:13 +0000
Message-ID: <16250e99a56442a4b98a5635c635c8f3@XBOX03.axis.com>
References: <cover.1577076251.git.akuster808@gmail.com>
	<222df6d6b832868c6e87334f8acdd74b730a91d6.1577076251.git.akuster808@gmail.com>
In-Reply-To: <222df6d6b832868c6e87334f8acdd74b730a91d6.1577076251.git.akuster808@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [1.44 02/18] runqueue/siggen: Allow handling of	equivalent hashes
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
X-List-Received-Date: Mon, 23 Dec 2019 08:25:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Armin Kuster
> Sent: den 23 december 2019 05:50
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [1.44 02/18] runqueue/siggen: Allow handling of
> equivalent hashes
>=20
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> Based on the hashserv's new ability to accept hash mappings, update
> runqueue
> to use this through a helper function in siggen.
>=20
> This addresses problems with meta-extsdk-toolchain and its dependency on
> gdb-cross which caused errors when building eSDK. See the previous commit
> for more details.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 39098b4ba2133f4d9229a0aa4fcf4c3e1291286a)
> ---
>  lib/bb/runqueue.py | 31 +++++++++++++++++++------------
>  lib/bb/siggen.py   | 26 ++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index bd7f03f..a869ba5 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2283,12 +2283,26 @@ class RunQueueExecute:
>                          for dep in self.rqdata.runtaskentries[tid].depen=
ds:
>                              procdep.append(dep)
>                          orighash =3D self.rqdata.runtaskentries[tid].has=
h
> -                        self.rqdata.runtaskentries[tid].hash =3D bb.pars=
e.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)=
])
> +                        newhash =3D bb.parse.siggen.get_taskhash(tid, pr=
ocdep, self.rqdata.dataCaches[mc_from_tid(tid)])
>                          origuni =3D self.rqdata.runtaskentries[tid].unih=
ash
> -                        self.rqdata.runtaskentries[tid].unihash =3D bb.p=
arse.siggen.get_unihash(tid)
> -                        logger.debug(1, "Task %s hash changes: %s->%s %s=
->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self=
.rqdata.runtaskentries[tid].unihash))
> +                        newuni =3D bb.parse.siggen.get_unihash(tid)
> +                        # FIXME, need to check it can come from sstate a=
t all for determinism?
> +                        remapped =3D False
> +                        if newuni =3D=3D origuni:
> +                            # Nothing to do, we match, skip code below
> +                            remapped =3D True
> +                        elif tid in self.scenequeue_covered or tid in se=
lf.sq_live:
> +                            # Already ran this setscene task or it runni=
ng. Report the new taskhash
> +                            remapped =3D bb.parse.siggen.report_unihash_=
equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
> +                            logger.info("Already covered setscene for %s=
 so ignoring rehash (remap)" % (tid))

Do we really want this level of logging? I have not commented on it for=20
master (yet), as I expect it is invaluable for RP & co that are currently=20
working hard on the hash server, but for me as common user of bitbake,=20
this is just noise (and a lot of it). I have a local patch that changes=20
this to logger.debug(1, ...) together with another logger.info("Task %s=20
unihash changed to %s" ...) a few lines earlier to get the cooker UI=20
reasonably back to usable. Also see below.

> +
> +                        if not remapped:
> +                            logger.debug(1, "Task %s hash changes: %s->%=
s %s->%s" % (tid, orighash, newhash, origuni, newuni))
> +                            self.rqdata.runtaskentries[tid].hash =3D new=
hash
> +                            self.rqdata.runtaskentries[tid].unihash =3D =
newuni
> +                            changed.add(tid)
> +
>                          next |=3D self.rqdata.runtaskentries[tid].revdep=
s
> -                        changed.add(tid)
>                          total.remove(tid)
>                          next.intersection_update(total)
>=20
> @@ -2307,18 +2321,11 @@ class RunQueueExecute:
>                  self.pending_migrations.add(tid)
>=20
>          for tid in self.pending_migrations.copy():
> -            if tid in self.runq_running:
> +            if tid in self.runq_running or tid in self.sq_live:
>                  # Too late, task already running, not much we can do now
>                  self.pending_migrations.remove(tid)
>                  continue
>=20
> -            if tid in self.scenequeue_covered or tid in self.sq_live:
> -                # Already ran this setscene task or it running
> -                # Potentially risky, should we report this hash as a mat=
ch?
> -                logger.info("Already covered setscene for %s so ignoring=
 rehash" % (tid))
> -                self.pending_migrations.remove(tid)
> -                continue
> -
>              valid =3D True
>              # Check no tasks this covers are running
>              for dep in self.sqdata.sq_covered_tasks[tid]:
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index e19812b..edf1010 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -525,6 +525,32 @@ class SignatureGeneratorUniHashMixIn(object):
>                  except OSError:
>                      pass
>=20
> +    def report_unihash_equiv(self, tid, taskhash, wanted_unihash, curren=
t_unihash, datacaches):
> +        try:
> +            extra_data =3D {}
> +            data =3D self.client().report_unihash_equiv(taskhash, self.m=
ethod, wanted_unihash, extra_data)
> +            bb.note('Reported task %s as unihash %s to %s (%s)' % (tid, =
wanted_unihash, self.server, str(data)))

This one and ...

> +
> +            if data is None:
> +                bb.warn("Server unable to handle unihash report")
> +                return False
> +
> +            finalunihash =3D data['unihash']
> +
> +            if finalunihash =3D=3D current_unihash:
> +                bb.note('Task %s unihash %s unchanged by server' % (tid,=
 finalunihash))
> +            elif finalunihash =3D=3D wanted_unihash:
> +                bb.note('Task %s unihash changed %s -> %s as wanted' % (=
tid, current_unihash, finalunihash))
> +                self.set_unihash(tid, finalunihash)
> +                return True
> +            else:
> +                # TODO: What to do here?
> +                bb.note('Task %s unihash reported as unwanted hash %s' %=
 (tid, finalunihash))

... and these also seem excessive. I have changed them locally to=20
bb.debug(1, ...) too.

> +        except hashserv.client.HashConnectionError as e:
> +            bb.warn('Error contacting Hash Equivalence Server %s: %s' % =
(self.server, str(e)))
> +
> +        return False
>=20
>  #
>  # Dummy class used for bitbake-selftest
> --
> 2.7.4

//Peter


