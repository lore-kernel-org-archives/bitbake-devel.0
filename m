Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RyVw0-0004gX-84
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Feb 2012 23:05:44 +0100
Received: by pbcum15 with SMTP id um15so3517090pbc.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Feb 2012 13:57:28 -0800 (PST)
Received-SPF: pass (google.com: domain of kergoth@gmail.com designates
	10.68.242.39 as permitted sender) client-ip=10.68.242.39; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of kergoth@gmail.com
	designates 10.68.242.39 as permitted sender)
	smtp.mail=kergoth@gmail.com;
	dkim=pass header.i=kergoth@gmail.com
Received: from mr.google.com ([10.68.242.39])
	by 10.68.242.39 with SMTP id wn7mr34738995pbc.89.1329515848892
	(num_hops = 1); Fri, 17 Feb 2012 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
	:mime-version:content-type;
	bh=UJxZc2IqXV7mxF6TWw04s4/f7+Gcf2jJY52siCrA6jc=;
	b=ABvf2ckkk/fve3+Cull93H/xSV0hUR5Lbs6raYSqj+fyG3lrMZ8gubs5S2cISn4Ylb
	A3u5+lQfCXn0/l8YdWunf70ebGVPqfmnij2qwh4CMi0HoJU1qxeavgSZO6Ya2Z5WfVMv
	XOmi9CrbW/7o6bLPc+pFgjmpsmgPovx5EObmI=
Received: by 10.68.242.39 with SMTP id wn7mr28144656pbc.89.1329515848816;
	Fri, 17 Feb 2012 13:57:28 -0800 (PST)
Received: from frey.local ([108.60.121.130])
	by mx.google.com with ESMTPS id l1sm6139355pbs.34.2012.02.17.13.57.27
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 17 Feb 2012 13:57:27 -0800 (PST)
Date: Fri, 17 Feb 2012 14:57:28 -0700
From: Christopher Larson <kergoth@gmail.com>
To: Caleb Crome <caleb@signalessence.com>
Message-ID: <DC9E475CD5DF496C81C7E0A334D639E2@gmail.com>
In-Reply-To: <CALy7FZE46mK5CakeRdq-jXgqeZQ8Uio6UWkUPMT5xEc1bDKvZw@mail.gmail.com>
References: <CALy7FZHSxCmTD+cTAuRASaQNuw7mqGu44oYkVybsdgTJ-H6r1g@mail.gmail.com>
	<CALy7FZE46mK5CakeRdq-jXgqeZQ8Uio6UWkUPMT5xEc1bDKvZw@mail.gmail.com>
X-Mailer: sparrow 1.5 (build 1043.1)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake Parser hangs on single core cpus
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
X-List-Received-Date: Fri, 17 Feb 2012 22:05:44 -0000
Content-Type: multipart/alternative; boundary="4f3ecd48_6b68079a_1b5f"

--4f3ecd48_6b68079a_1b5f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Applied. In the future, please stick to the conventions for git commit messages, and add a signed-off-by line. I've adjusted them when I applied it for now, you can look at that as an example of what to do. Thanks for the patch, it's much appreciated.

-- 
Christopher Larson


On Friday, February 17, 2012 at 2:24 PM, Caleb Crome wrote:

> Argh, for some reason git send-email just won't work for me. I it up,
> it asks to confirm, I say, 'y', then nothing. it just hangs.
> 
> Anyway, here's the patch as an attachment. Will that work for you?
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> 
> 
> 
> 
> Attachments: 
> - 0001-There-seems-to-be-a-bug-in-the-number-of-Parser-thre.patch
> 



--4f3ecd48_6b68079a_1b5f
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div style=3D=22font-family: Helvetica; font-size: 13px; =
=22>Applied. In the future, please stick to the conventions for git commi=
t messages, and add a signed-off-by line. I've adjusted them when I appli=
ed it for now, you can look at that as an example of what to do. Thanks f=
or the patch, it's much appreciated.<br></div>
                <div><div><br></div><div>--&nbsp;</div><div>Christopher L=
arson</div><div><br></div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On =46riday, =46ebruar=
y 17, 2012 at 2:24 PM, Caleb Crome wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div>Argh, for some reason git send-e=
mail just won't work for me.  I it up,</div><div>it asks to confirm, I sa=
y, 'y', then nothing.  it just hangs.</div><div><br></div><div>Anyway, he=
re's the patch as an attachment.  Will that work for you=3F</div></div><d=
iv><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
</div><div>bitbake-devel mailing list</div><div><a href=3D=22mailto:bitba=
ke-devel=40lists.openembedded.org=22>bitbake-devel=40lists.openembedded.o=
rg</a></div><div><a href=3D=22http://lists.linuxtogo.org/cgi-bin/mailman/=
listinfo/bitbake-devel=22>http://lists.linuxtogo.org/cgi-bin/mailman/list=
info/bitbake-devel</a></div></div></div></span>
                =20
                =20
                <div style=3D=22border-bottom: 1px solid =23f0f0f0; heigh=
t: 10px;=22>
                </div>
                <br>
                =20
                <div style=3D=22font-weight: bold; font-size: 14px; margi=
n-bottom: 5px;=22>Attachments:</div>
                =20
                =20
                =20
                =20
                =20
                =20
                =20
                <div>
                    =20
                    <div style=3D=22=22>- 0001-There-seems-to-be-a-bug-in=
-the-number-of-Parser-thre.patch</div>
                    =20
                </div>
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            

--4f3ecd48_6b68079a_1b5f--
