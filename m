Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1ShhIG-0007mT-BE
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 15:19:28 +0200
Received: by werg55 with SMTP id g55so376038wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2012 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=8+pN39+M7jxyOvMiPH8oo3krRjKlDQjpMWa6QIOONcs=;
	b=XASRCKxmZpUS/adGoz0+/zm1CHLZixG/ZSmjMl5h2KlfVygQknzTe1YDuUADibnDD8
	g4VkTzc8UV8ShsZn1L20czkPBWxG3+bsZbjq9ZJXoeBqZydetzFeTo/Wv4vQAHgvPlMD
	UAgnSm0cJsgJyZYjP/sZttwYLpF+nW0rJuUqX1nEZ2DWhvZOvVY0JT5At1z0TgsXi4tS
	raTtUr7uSbEeGZQGL6QaLx0qyOy+xGaeLj9DAt0h92X63kQ12OQ3VaPhl2+sH8RJgS7I
	qzipFRqEFAr78w4g1Ef/IDQN2GZvzsdqZuMp00YzmP902Qch327WBA83RXPIVfyuprJJ
	pKPA==
MIME-Version: 1.0
Received: by 10.180.102.228 with SMTP id fr4mr20362779wib.6.1340284122311;
	Thu, 21 Jun 2012 06:08:42 -0700 (PDT)
Received: by 10.216.234.92 with HTTP; Thu, 21 Jun 2012 06:08:42 -0700 (PDT)
In-Reply-To: <1340280968.1640.96.camel@ted>
References: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
	<1340280968.1640.96.camel@ted>
Date: Thu, 21 Jun 2012 15:08:42 +0200
Message-ID: <CAC1BbcSr8K79m6idqVvDDrYG1KxgrMEVwmDVb2KWZ8xrUC0Z9Q@mail.gmail.com>
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: do not try to checksum a socket
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
X-List-Received-Date: Thu, 21 Jun 2012 13:19:28 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21 June 2012 14:16, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Mon, 2012-06-18 at 13:28 +0200, Bernhard Reutner-Fischer wrote:
>> computing the md5 of a socket does not work too well.
>>
>> Traceback (most recent call last):
>> =A0 File "/scratch/src/oe/bitbake/build/lib/bb/siggen.py", line 172, in =
SignatureGeneratorOEBasic.get_taskhash(fn=3D'/scratch/src/oe/openembedded-c=
ore/meta/recipes-core/uclibc/uclibc_git.bb', task=3D'do_fetch', deps=3D[], =
dataCache=3D<bb.cache.CacheData object at 0xd95890>):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0if task in dataCache.file_checksums[fn]:
>> =A0 =A0 > =A0 =A0 =A0 =A0 =A0 =A0checksums =3D bb.fetch2.get_file_checks=
ums(dataCache.file_checksums[fn][task], recipename)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (f,cs) in checksums:
>> =A0 File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line=
 627, in get_file_checksums(filelist=3D'/scratch/src/uClibc/ /scratch/src/o=
e/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.machine /scr=
atch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.di=
stro', pn=3D'uclibc'):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fullpth =3D os.path.j=
oin(root, name)
>> =A0 =A0 > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0checksum =3D checksum_f=
ile(fullpth)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if checksum:
>> =A0 File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line=
 605, in checksum_file(f=3D'/scratch/src/uClibc/test/inet/socktest'):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0try:
>> =A0 =A0 > =A0 =A0 =A0 =A0 =A0 =A0checksum =3D _checksum_cache.get_checks=
um(f)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0except OSError as e:
>> =A0 File "/scratch/src/oe/bitbake/build/lib/bb/checksum.py", line 78, in=
 FileChecksumCache.get_checksum(f=3D'/scratch/src/uClibc/test/inet/socktest=
'):
>>
>> =A0 =A0 > =A0 =A0 =A0 =A0hashval =3D bb.utils.md5_file(f)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0self.cachedata_extras[0][f] =3D (cmtime, hash=
val)
>> =A0 File "/scratch/src/oe/bitbake/build/lib/bb/utils.py", line 362, in m=
d5_file(filename=3D'/scratch/src/uClibc/test/inet/socktest'):
>>
>> =A0 =A0 > =A0 =A0for line in open(filename):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0m.update(line)
>> IOError: [Errno 6] No such device or address: '/scratch/src/uClibc/test/=
inet/socktest'
>
> Can you give some details on how to reproduce this? I'm guessing this is
> due to some kind of proxy configuration?

I'm using an rsync of my local clone, like (The only change i have in
an otherwise pristine oe-core):
$ sed -e "/#/d;/^[[:space:]]*$/d" meta/recipes-core/uclibc/uclibc_git.bb
require uclibc.inc
DEFAULT_PREFERENCE =3D "9"
PV =3D "0.9.33+git0"
PR =3D "${INC_PR}.1"
PROVIDES +=3D "virtual/${TARGET_PREFIX}libc-for-gcc"
FILESPATH =3D "${@base_set_filespath([ '${FILE_DIRNAME}/uclibc-git' ], d)}"
SRC_URI =3D "file:///scratch/src/uClibc/;branch=3Dmaster;protocol=3Drsync;r=
ebaseable=3D1
\
	file://uClibc.machine \
	file://uClibc.distro \
	"
S =3D "${WORKDIR}/uClibc"

>
> What is worrying me a bit is that we shouldn't be calling the checksum
> code for git repositories at all. Whilst this fix no doubt avoids the
> problem, I'm worried there might be something deeper going on...

Could it be that the logic to deduce the fetcher is somehow broken?

Indeed, this was failing for me a couple of weeks ago with a similar SRC_UR=
I.
Back then i could not use file:///mydir;protocol=3Dgit (i.e. create a
clone from a clone living on the local filesystem) so had to resort
back to protocol=3Drsync.
There was a socket lying around in that directory, a leftover from
some testsuite run.

Good point of yours but i do not currently have time to dig into this, sorr=
y :-(
so please ignore the patch!

cheers,
>
> Cheers,
>
> Richard
>
>> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
>> ---
>> =A0lib/bb/fetch2/__init__.py | =A0 =A01 +
>> =A01 file changed, 1 insertion(+)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 324eef2..0c0d60d 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -601,6 +601,7 @@ def get_file_checksums(filelist, pn):
>> =A0 =A0 =A0"""
>>
>> =A0 =A0 =A0def checksum_file(f):
>> + =A0 =A0 =A0 =A0if not os.path.isfile(f): return None
>> =A0 =A0 =A0 =A0 =A0try:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0checksum =3D _checksum_cache.get_checksum(f)
>> =A0 =A0 =A0 =A0 =A0except OSError as e:
>
>


