Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U6jPw-0007WP-TE for bitbake-devel@lists.openembedded.org;
	Sat, 16 Feb 2013 16:11:09 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1GF1Fjh016918; Sat, 16 Feb 2013 15:01:15 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GVRGrPoX1klV; Sat, 16 Feb 2013 15:01:15 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1GF18kv016914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 16 Feb 2013 15:01:11 GMT
Message-ID: <1361026488.31795.60.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin =?ISO-8859-1?Q?Erts=E5s?= <martiert@gmail.com>
Date: Sat, 16 Feb 2013 14:54:48 +0000
In-Reply-To: <511F8EC6.1080201@gmail.com>
References: <1360281302.10722.68.camel@ted>
	<CABcZANmd9_bcAUizAR3JiSX368HJsKhzGrGPkqAsbMsw2G9=ig@mail.gmail.com>
	<1360944017.31795.1.camel@ted> <511F8EC6.1080201@gmail.com>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
X-MIME-Autoconverted: from 8bit to quoted-printable by dan.rpsys.net id
	r1GF1Fjh016918
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils: Use rm -rf in remove()
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
X-List-Received-Date: Sat, 16 Feb 2013 15:11:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2013-02-16 at 14:51 +0100, Martin Erts=C3=A5s wrote:
> On 02/15/13 17:00, Richard Purdie wrote:
> > On Thu, 2013-02-07 at 18:08 -0700, Chris Larson wrote:
> >> On Thu, Feb 7, 2013 at 4:55 PM, Richard Purdie
> >> <richard.purdie@linuxfoundation.org> wrote:
> >>          -                shutil.rmtree(name)
> >>          +                # shutil.rmtree(name) would be ideal but i=
ts
> >>          too slow
> >>          +                subprocess.call('rm -rf %s' % path,
> >>          shell=3DTrue)
> >>
> >> This is a good idea, but I'm curious about forking off a shell proce=
ss
> >> for it. I'd think this would work as well: subprocess.call(['rm',
> >> '-rf', path])
> > path can have wildcards in it. The code wasn't entirely obvious so I'=
ve
> > tweaked it after your/Peter's comments. I'm hoping it will help the
> > problems Martin was seeing too.
> >
> > Cheers,
> >
> > Richard
> >
> >
> I think this is a good idea as well. One thing I would question though,=
=20
> is to have this in the except clause. Why not:
>=20
>      for name in glob.glob(path):
>          try:
> 	    if recurse and os.path.isdir(path):
> 	       subprocess.call('rm -rf %s' % path, shell=3DTrue)
> 	       return
> 	    os.unlink(name)
>          except OSError as exc:
>              if exc.errno !=3D errno.ENOENT:
>                  raise
>=20
>=20
> Personally I feel it is cleaner to have all the remove possibilities in=
=20
> the try, and let the exceptions be in except. Kind of feel it is wrong=20
> to let the recursive case be handled in the exception, as I don't see i=
t=20
> being an exceptional case to delete a folder.
>=20
> Also, unfortunately your patch would not fix osx, as EISDIR is not the=20
> error that is returned there. What I get is either a EPERM or an EACCES=
=20
> (not on a mac now, so can't check it until monday). So osx would still=20
> fall through to the raise.

Can you take a look at the patch I ended up committing? Its basically as
you describe above expect I moved the subprocess outside the for loop as
well.

(http://git.openembedded.org/bitbake/commit/?id=3D96088ebdec08e49ba9e8dbc=
ac437bfcdc21f5983)

Cheers,

Richard





