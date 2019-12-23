Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
	[209.85.210.177])
	by mail.openembedded.org (Postfix) with ESMTP id 70CFB7D58A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 16:18:05 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id i23so3988848pfo.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=4NEGsPvQFIhLudcLWUA0mr1V5AvCVEBV2m981wzB+9w=;
	b=m/WigNnUYcgEcU3VH4L5JxLqrktHN5TePPIf9bHJS+MunXBIm3OmdPKOkPRlS5qmeK
	xU1wrjVJc9DTSRaeG5qA2+eE59irDi8J72dgsbrS0WJQC1UiVEUPI3RkhxkbqdyAdERX
	KPv4Nfqsngf4q2YRx7VB68GsQxTr63KSM/mcqImC+2BcIWKaMqSYDWfzRE4NcyrLlEbp
	/mgvoCdhgdKyK6Hfm6pH7ZBQsSzn0p6qo9aPgq62cl0FV4PonQvY6WlGXIqIRxONwdFo
	AhgofPK5NCRSlBc0U7OJwoyvHGr42vW9vo3RdECqcWCy0Q6aWWp8EumIWOPDj+M5QU1S
	dStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=4NEGsPvQFIhLudcLWUA0mr1V5AvCVEBV2m981wzB+9w=;
	b=LpQT9a4GcnQ+BBy315IPG7FIu6jyqhp33blh7ceitQSMyeFv4zRUC8+rlym1BdXQ7w
	kTuAI+Foy7U6e1zrRoXxWzN86VCyidwmz0CcwM3GKWIBpaNaihkpqBV/lunMQkwIIKPl
	o2Zvmim15O99+OBwaz2wcIgBTNl5NJg8gci10fCRbPfZxhDUaPM2l4ARPcrHEgtXYvYn
	MRF0z1i/K6WP4WYu71jfLeral86Fy6bBGzzxpTjXJeoR4OBjVeS2bFGfc84rqiPwtoil
	BH8h3Ay0e72dcnkyFQkDI2PCohDSrZwclb8brpOZuJ9LPHBx/Q/Wy/fuJAkoNuyDQ0pV
	rmzg==
X-Gm-Message-State: APjAAAW2VFf/qrQrFFWJBckGiLuRwGZlfQIWI9kikJjIVIYfqt5lbS9R
	XQ79pOhxD408f2yOn2pAz3BBN+a6+qQ=
X-Google-Smtp-Source: APXvYqy+xrTfSPoPLb75h+AidRyK14v6O21jXspcSrnRhbazFe6j99xvKVZu8PI2DDFESzbKfSP8Vg==
X-Received: by 2002:a63:5924:: with SMTP id n36mr32350655pgb.43.1577117886355; 
	Mon, 23 Dec 2019 08:18:06 -0800 (PST)
Received: from ?IPv6:2601:202:4180:a5c0:30f1:af1:c5e0:a746?
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	c1sm25453126pfa.51.2019.12.23.08.18.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 23 Dec 2019 08:18:05 -0800 (PST)
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <cover.1577076251.git.akuster808@gmail.com>
	<222df6d6b832868c6e87334f8acdd74b730a91d6.1577076251.git.akuster808@gmail.com>
	<16250e99a56442a4b98a5635c635c8f3@XBOX03.axis.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <38c7664b-8a7e-afb8-40b5-0551ec6ba8bb@gmail.com>
Date: Mon, 23 Dec 2019 08:18:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <16250e99a56442a4b98a5635c635c8f3@XBOX03.axis.com>
Subject: Re: [1.44 02/18] runqueue/siggen: Allow handling of equivalent hashes
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
X-List-Received-Date: Mon, 23 Dec 2019 16:18:05 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 12/23/19 12:25 AM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>> bounces@lists.openembedded.org> On Behalf Of Armin Kuster
>> Sent: den 23 december 2019 05:50
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [1.44 02/18] runqueue/siggen: Allow handling =
of
>> equivalent hashes
>>
>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>>
>> Based on the hashserv's new ability to accept hash mappings, update
>> runqueue
>> to use this through a helper function in siggen.
>>
>> This addresses problems with meta-extsdk-toolchain and its dependency =
on
>> gdb-cross which caused errors when building eSDK. See the previous com=
mit
>> for more details.
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> (cherry picked from commit 39098b4ba2133f4d9229a0aa4fcf4c3e1291286a)
>> ---
>>  lib/bb/runqueue.py | 31 +++++++++++++++++++------------
>>  lib/bb/siggen.py   | 26 ++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+), 12 deletions(-)
>>
>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>> index bd7f03f..a869ba5 100644
>> --- a/lib/bb/runqueue.py
>> +++ b/lib/bb/runqueue.py
>> @@ -2283,12 +2283,26 @@ class RunQueueExecute:
>>                          for dep in self.rqdata.runtaskentries[tid].de=
pends:
>>                              procdep.append(dep)
>>                          orighash =3D self.rqdata.runtaskentries[tid].=
hash
>> -                        self.rqdata.runtaskentries[tid].hash =3D bb.p=
arse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid=
(tid)])
>> +                        newhash =3D bb.parse.siggen.get_taskhash(tid,=
 procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
>>                          origuni =3D self.rqdata.runtaskentries[tid].u=
nihash
>> -                        self.rqdata.runtaskentries[tid].unihash =3D b=
b.parse.siggen.get_unihash(tid)
>> -                        logger.debug(1, "Task %s hash changes: %s->%s=
 %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni,=
 self.rqdata.runtaskentries[tid].unihash))
>> +                        newuni =3D bb.parse.siggen.get_unihash(tid)
>> +                        # FIXME, need to check it can come from sstat=
e at all for determinism?
>> +                        remapped =3D False
>> +                        if newuni =3D=3D origuni:
>> +                            # Nothing to do, we match, skip code belo=
w
>> +                            remapped =3D True
>> +                        elif tid in self.scenequeue_covered or tid in=
 self.sq_live:
>> +                            # Already ran this setscene task or it ru=
nning. Report the new taskhash
>> +                            remapped =3D bb.parse.siggen.report_uniha=
sh_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
>> +                            logger.info("Already covered setscene for=
 %s so ignoring rehash (remap)" % (tid))
> Do we really want this level of logging?=20
I appreciate you taking the time out to review the patch series.

For keeping backporting easier while master continues to address hash
equivalence, it seemed responsible to keep patches as they are.

Also for my own sanity, I needed to start collection fixes for hq as I
know we are not finished sorting that out and I feel like there will be
more to come.
> I have not commented on it for=20
> master (yet), as I expect it is invaluable for RP & co that are current=
ly=20
> working hard on the hash server, but for me as common user of bitbake, =

> this is just noise (and a lot of it). I have a local patch that changes=
=20
> this to logger.debug(1, ...) together with another logger.info("Task %s=
=20
> unihash changed to %s" ...) a few lines earlier to get the cooker UI=20
> reasonably back to usable. Also see below.

I will wait for Master for any logging changes made there before
diverging 1.44. The next zeus update which is currently scheduled after
M2. ( Jan/2021) and if hq is still showing signs of being problematic, i
suspect this entire series may wait for more stability from master.

regards,
Armin

>
>> +
>> +                        if not remapped:
>> +                            logger.debug(1, "Task %s hash changes: %s=
->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
>> +                            self.rqdata.runtaskentries[tid].hash =3D =
newhash
>> +                            self.rqdata.runtaskentries[tid].unihash =3D=
 newuni
>> +                            changed.add(tid)
>> +
>>                          next |=3D self.rqdata.runtaskentries[tid].rev=
deps
>> -                        changed.add(tid)
>>                          total.remove(tid)
>>                          next.intersection_update(total)
>>
>> @@ -2307,18 +2321,11 @@ class RunQueueExecute:
>>                  self.pending_migrations.add(tid)
>>
>>          for tid in self.pending_migrations.copy():
>> -            if tid in self.runq_running:
>> +            if tid in self.runq_running or tid in self.sq_live:
>>                  # Too late, task already running, not much we can do =
now
>>                  self.pending_migrations.remove(tid)
>>                  continue
>>
>> -            if tid in self.scenequeue_covered or tid in self.sq_live:=

>> -                # Already ran this setscene task or it running
>> -                # Potentially risky, should we report this hash as a =
match?
>> -                logger.info("Already covered setscene for %s so ignor=
ing rehash" % (tid))
>> -                self.pending_migrations.remove(tid)
>> -                continue
>> -
>>              valid =3D True
>>              # Check no tasks this covers are running
>>              for dep in self.sqdata.sq_covered_tasks[tid]:
>> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
>> index e19812b..edf1010 100644
>> --- a/lib/bb/siggen.py
>> +++ b/lib/bb/siggen.py
>> @@ -525,6 +525,32 @@ class SignatureGeneratorUniHashMixIn(object):
>>                  except OSError:
>>                      pass
>>
>> +    def report_unihash_equiv(self, tid, taskhash, wanted_unihash, cur=
rent_unihash, datacaches):
>> +        try:
>> +            extra_data =3D {}
>> +            data =3D self.client().report_unihash_equiv(taskhash, sel=
f.method, wanted_unihash, extra_data)
>> +            bb.note('Reported task %s as unihash %s to %s (%s)' % (ti=
d, wanted_unihash, self.server, str(data)))
> This one and ...
>
>> +
>> +            if data is None:
>> +                bb.warn("Server unable to handle unihash report")
>> +                return False
>> +
>> +            finalunihash =3D data['unihash']
>> +
>> +            if finalunihash =3D=3D current_unihash:
>> +                bb.note('Task %s unihash %s unchanged by server' % (t=
id, finalunihash))
>> +            elif finalunihash =3D=3D wanted_unihash:
>> +                bb.note('Task %s unihash changed %s -> %s as wanted' =
% (tid, current_unihash, finalunihash))
>> +                self.set_unihash(tid, finalunihash)
>> +                return True
>> +            else:
>> +                # TODO: What to do here?
>> +                bb.note('Task %s unihash reported as unwanted hash %s=
' % (tid, finalunihash))
> ... and these also seem excessive. I have changed them locally to=20
> bb.debug(1, ...) too.
>
>> +        except hashserv.client.HashConnectionError as e:
>> +            bb.warn('Error contacting Hash Equivalence Server %s: %s'=
 % (self.server, str(e)))
>> +
>> +        return False
>>
>>  #
>>  # Dummy class used for bitbake-selftest
>> --
>> 2.7.4
> //Peter
>



