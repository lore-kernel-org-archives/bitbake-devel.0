Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1S9kPW-0004JN-QB
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 22:46:39 +0100
Received: by obqv19 with SMTP id v19so1562724obq.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Mar 2012 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
	:mime-version:content-type;
	bh=mIO0K98h8diCABDOwdFBDVy7e+SKfEif29ciTsoxI9s=;
	b=CZdIhedsBaWURhGuixg/0iIQqyP68hgbxB/OrcOmIz4HcACYk2vo1d0Z/o5Q82a4+e
	ykAJ2X26+MkS15jLOwYUvw1njTIyA9cvngfFhR7EOnak5vms4QH5Ld9mvdahe09lwdtY
	q6Kb24J49WqfvxDIcD5MfLpUfJXlw9JXhOSYosudAEF2Ol2G2x7dT2yVt6AQ3AxxAr3H
	nA/Q1N7hA4gjp/8FhkWnEpfJmkpztSdQ+eWeN7RQj7r8nhKRECBgjgmloGf9agg7G04q
	30LPE7PUd1Ia842N5EtrsZtG8SfDC+ksbaS17OUVwtY4KpQMQj3Gi1IAi3m+lW1sGtgi
	iuwQ==
Received: by 10.182.12.37 with SMTP id v5mr15331468obb.16.1332193066613;
	Mon, 19 Mar 2012 14:37:46 -0700 (PDT)
Received: from frey.local (ip68-110-79-242.ph.ph.cox.net. [68.110.79.242])
	by mx.google.com with ESMTPS id c2sm10976228oeb.13.2012.03.19.14.37.44
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 19 Mar 2012 14:37:45 -0700 (PDT)
Date: Mon, 19 Mar 2012 14:37:42 -0700
From: Christopher Larson <kergoth@gmail.com>
To: Denys Dmytriyenko <denis@denix.org>
Message-ID: <9DB46E3A8C854D2595CB6F683FB6D1D0@gmail.com>
In-Reply-To: <20120319203213.GC15554@denix.org>
References: <4F605E85.7070904@windriver.com>
	<1331718176.18586.15.camel@ted> <4F61926D.1060709@windriver.com>
	<4F619CD4.4090103@windriver.com> <20120315080310.GC4973@jama.jama.net>
	<4F61B1D0.2080306@windriver.com> <20120315092122.GE4973@jama.jama.net>
	<20120315181844.GE30363@denix.org>
	<20120316064152.GA3855@jama.jama.net>
	<20120319203213.GC15554@denix.org>
X-Mailer: sparrow 1.5 (build 1043.1)
MIME-Version: 1.0
Cc: philb@gnu.org, Kang Kai <Kai.Kang@windriver.com>,
	bitbake-devel@lists.openembedded.org, Martin Jansa <martin.jansa@gmail.com>
Subject: Re: How to identify WORKDIR?
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
X-List-Received-Date: Mon, 19 Mar 2012 21:46:39 -0000
Content-Type: multipart/alternative; boundary="4f67a726_515f007c_aa0"

--4f67a726_515f007c_aa0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

rm_old_work seems to do exactly what it sounds like. It removes *old* workdirs from previous versions of the recipe to keep it from bloating without bound if you retain the same tmpdir.

-- 
Christopher Larson


On Monday, March 19, 2012 at 1:32 PM, Denys Dmytriyenko wrote:

> On Fri, Mar 16, 2012 at 07:41:52AM +0100, Martin Jansa wrote:
> > On Thu, Mar 15, 2012 at 02:18:44PM -0400, Denys Dmytriyenko wrote:
> > > On Thu, Mar 15, 2012 at 10:21:22AM +0100, Martin Jansa wrote:
> > > > On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:
> > > > > On 2012???03???15??? 16:03, Martin Jansa wrote:
> > > > > > On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
> > > > > > > On 2012???03???15??? 14:55, Kang Kai wrote:
> > > > > > > > On 2012???03???14??? 17:42, Richard Purdie wrote:
> > > > > > > > > On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> > > > > > > > > > Hi All,
> > > > > > > > > > 
> > > > > > > > > > I write a script to clean up WORKDIR that remove the obsoleted
> > > > > > > > > > packages' build directories.
> > > > > > > > > > The script accept a argument as BUILDDIR and I use this clause to
> > > > > > > > > > identify the WORKDIR:
> > > > > > > > > > 
> > > > > > > > > > workdir = os.path.join(builddir, 'tmp/work')
> > > > > > > > > > 
> > > > > > > > > > Then validate the workdir exists or not. It works for me but hardcode
> > > > > > > > > > here as Richard point out.
> > > > > > > > > > So is there a better way to get the WORKDIR here? Thanks.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I was thinking of something like:
> > > > > > > > > 
> > > > > > > > > bitbake -e | grep ^WORKDIR
> > > > > > > And the result is something like that:
> > > > > > > WORKDIR="/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x86_64-poky-linux/bblayers-1.0-r0"
> > > > > > > 
> > > > > > > Is it ok to remove 2 items seperated by slash at the end of string?
> > > > > > > Right now is:
> > > > > > > "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"
> > > > > > > 
> > > > > > 
> > > > > > Aren't you looking for ^TMPDIR ?
> > > > > > 
> > > > > 
> > > > > 
> > > > > If use WORKDIR = TMPDIR/"work", it is still hard coding.
> > > > 
> > > > Assuming 2 items at the end won't work for people using rm_old_work:
> > > > http://git.openembedded.org/meta-micro/commit/?id=fcf525654915edb9650f1a6c2852f336366f8b2f
> > > > or slightly different version:
> > > > http://git.shr-project.org/git/?p=meta-smartphone.git;a=blob;f=meta-shr/classes/rm_old_work.bbclass
> > > > 
> > > 
> > > 
> > > Martin,
> > > 
> > > Can you please point me to more details about this class - any background or 
> > > discussions... Thanks.
> > > 
> > 
> > 
> > Hi,
> > 
> > Well it works better then rm_work with sstate and the original class is
> > from meta-micro (so maybe ask pb if you want more details, but the class
> > is quite simple). I've just replaced last directory name because of this
> > issue:
> > 
> > http://git.shr-project.org/git/?p=meta-smartphone.git;a=commit;h=0d4c17de1ba7343d82bb10c311754e29d573c485
> 
> Martin,
> 
> Hmm, my understanding those are slightly different classes - rm_work cleans 
> WORKDIR after the build to save space, while this rm_old_work seems to clean 
> up before the build. I tried searching for any previous discussions of this 
> class or any other rationale, but even the commit itself doesn't provide much 
> explanation for it...
> 
> Phil,
> 
> Do you mind giving a short description of this peculiar rm_old_work class? :) 
> Thanks.
> 
> -- 
> Denys
> 
> 
> > > > And I think more people have different "tmp/" part e.g. default would be
> > > > "tmp-eglibc/" (thanks to TCLIBCAPPEND
> > > > meta/conf/distro/defaultsetup.conf:TMPDIR .= "${TCLIBCAPPEND}"), but "work" is 
> > > > quite common.
> > > > 
> > > > meta/conf/bitbake.conf:
> > > > WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
> > > > meta-shr/classes/rm_old_work.bbclass:
> > > > WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${PF}"
> > > > meta-micro/classes/rm_old_work.bbclass:
> > > > WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${PV}-${PR}"
> > > > 
> > > > Cheers,
> > > > 
> > > > > 
> > > > > > > Regards,
> > > > > > > Kai
> > > > > > > 
> > > > > > > > If get WORKDIR in this way, I'll update the script with no argument
> > > > > > > > because the argument is useless to identify the WORKDIR.
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Kai
> > > > > > > > > since you already call into bitbake in the script in question.
> > > > > > > > > 
> > > > > > > > > Cheers,
> > > > > > > > > 
> > > > > > > > > Richard
> > > > > > > > 
> > > > > > > > _______________________________________________
> > > > > > > > bitbake-devel mailing list
> > > > > > > > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > > > > > > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > bitbake-devel mailing list
> > > > > > > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > > > > > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > > -- 
> > > > Martin 'JaMa' Jansa jabber: Martin.Jansa@gmail.com (mailto:Martin.Jansa@gmail.com)
> > > > 
> > > 
> > > 
> > > 
> > > 
> > > > _______________________________________________
> > > > bitbake-devel mailing list
> > > > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > > 
> > > 
> > > 
> > 
> > 
> > -- 
> > Martin 'JaMa' Jansa jabber: Martin.Jansa@gmail.com (mailto:Martin.Jansa@gmail.com)
> > 
> 
> 
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> 
> 



--4f67a726_515f007c_aa0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div style=3D=22font-family: Helvetica; font-size: 13px; =
=22>rm=5Fold=5Fwork seems to do exactly what it sounds like. It removes *=
old* workdirs from previous versions of the recipe to keep it from bloati=
ng without bound if you retain the same tmpdir.<br></div>
                <div><div><br></div><div>--&nbsp;</div><div>Christopher L=
arson</div><div><br></div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On Monday, March 19, 2=
012 at 1:32 PM, Denys Dmytriyenko wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div>On =46ri, Mar 16, 2012 at 07:41:=
52AM +0100, Martin Jansa wrote:</div><blockquote type=3D=22cite=22><div><=
div>On Thu, Mar 15, 2012 at 02:18:44PM -0400, Denys Dmytriyenko wrote:</d=
iv><blockquote type=3D=22cite=22><div><div>On Thu, Mar 15, 2012 at 10:21:=
22AM +0100, Martin Jansa wrote:</div><blockquote type=3D=22cite=22><div><=
div>On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:</div><block=
quote type=3D=22cite=22><div><div>On 2012=3F=3F=3F03=3F=3F=3F15=3F=3F=3F =
16:03, Martin Jansa wrote:</div><blockquote type=3D=22cite=22><div><div>O=
n Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:</div><blockquote=
 type=3D=22cite=22><div><div>On 2012=3F=3F=3F03=3F=3F=3F15=3F=3F=3F 14:55=
, Kang Kai wrote:</div><blockquote type=3D=22cite=22><div><div>On 2012=3F=
=3F=3F03=3F=3F=3F14=3F=3F=3F 17:42, Richard Purdie wrote:</div><blockquot=
e type=3D=22cite=22><div><div>On Wed, 2012-03-14 at 17:01 +0800, Kang Kai=
 wrote:</div><blockquote type=3D=22cite=22><div><div>Hi All,</div><div><b=
r></div><div>I write a script to clean up WORKDIR that remove the obsolet=
ed</div><div>packages' build directories.</div><div>The script accept a a=
rgument as BUILDDIR and I use this clause to</div><div>identify the WORKD=
IR:</div><div><br></div><div>       workdir =3D os.path.join(builddir, 't=
mp/work')</div><div><br></div><div>Then validate the workdir exists or no=
t. It works for me but hardcode</div><div>here as Richard point out.</div=
><div>So is there  a better way to get the WORKDIR here=3F Thanks.</div><=
/div></blockquote><div>I was thinking of something like:</div><div><br></=
div><div>bitbake -e =7C grep =5EWORKDIR</div></div></blockquote></div></b=
lockquote><div>And the result is something like that:</div><div>WORKDIR=3D=
=22/mnt/sda10/poky-all-platform/build-qemux86=5F64/tmp/work/x86=5F64-poky=
-linux/bblayers-1.0-r0=22</div><div><br></div><div>Is it ok to remove 2 i=
tems seperated by slash at the end of string=3F</div><div>Right now is:</=
div><div>=22/mnt/sda10/poky-all-platform/build-qemux86=5F64/tmp/work/=22<=
/div></div></blockquote><div>Aren't you looking for =5ETMPDIR =3F</div></=
div></blockquote><div><br></div><div>If use WORKDIR =3D TMPDIR/=22work=22=
, it is still hard coding.</div></div></blockquote><div><br></div><div>As=
suming 2 items at the end won't work for people using rm=5Fold=5Fwork:</d=
iv><div><a href=3D=22http://git.openembedded.org/meta-micro/commit/=3Fid=3D=
fcf525654915edb9650f1a6c2852f336366f8b2f=22>http://git.openembedded.org/m=
eta-micro/commit/=3Fid=3Dfcf525654915edb9650f1a6c2852f336366f8b2f</a></di=
v><div>or slightly different version:</div><div><a href=3D=22http://git.s=
hr-project.org/git/=3Fp=3Dmeta-smartphone.git;a=3Dblob;f=3Dmeta-shr/class=
es/rm=5Fold=5Fwork.bbclass=22>http://git.shr-project.org/git/=3Fp=3Dmeta-=
smartphone.git;a=3Dblob;f=3Dmeta-shr/classes/rm=5Fold=5Fwork.bbclass</a><=
/div></div></blockquote><div><br></div><div>Martin,</div><div><br></div><=
div>Can you please point me to more details about this class - any backgr=
ound or </div><div>discussions... Thanks.</div></div></blockquote><div><b=
r></div><div>Hi,</div><div><br></div><div>Well it works better then rm=5F=
work with sstate and the original class is</div><div>from meta-micro (so =
maybe ask pb if you want more details, but the class</div><div>is quite s=
imple). I've just replaced last directory name because of this</div><div>=
issue:</div><div><br></div><div><a href=3D=22http://git.shr-project.org/g=
it/=3Fp=3Dmeta-smartphone.git;a=3Dcommit;h=3D0d4c17de1ba7343d82bb10c31175=
4e29d573c485=22>http://git.shr-project.org/git/=3Fp=3Dmeta-smartphone.git=
;a=3Dcommit;h=3D0d4c17de1ba7343d82bb10c311754e29d573c485</a></div></div><=
/blockquote><div><br></div><div>Martin,</div><div><br></div><div>Hmm, my =
understanding those are slightly different classes - rm=5Fwork cleans </d=
iv><div>WORKDIR after the build to save space, while this rm=5Fold=5Fwork=
 seems to clean </div><div>up before the build. I tried searching for any=
 previous discussions of this </div><div>class or any other rationale, bu=
t even the commit itself doesn't provide much </div><div>explanation for =
it...</div><div><br></div><div>Phil,</div><div><br></div><div>Do you mind=
 giving a short description of this peculiar rm=5Fold=5Fwork class=3F :) =
</div><div>Thanks.</div><div><br></div><div>-- </div><div>Denys</div><div=
><br></div><div><br></div><blockquote type=3D=22cite=22><div><blockquote =
type=3D=22cite=22><div><blockquote type=3D=22cite=22><div><div>And I thin=
k more people have different =22tmp/=22 part e.g. default would be</div><=
div>=22tmp-eglibc/=22 (thanks to TCLIBCAPPEND</div><div>meta/conf/distro/=
defaultsetup.conf:TMPDIR .=3D =22=24=7BTCLIBCAPPEND=7D=22), but =22work=22=
 is </div><div>quite common.</div><div><br></div><div>meta/conf/bitbake.c=
onf:</div><div>WORKDIR =3D =22=24=7BTMPDIR=7D/work/=24=7BMULTIMACH=5FTARG=
ET=5FSYS=7D/=24=7BP=46=7D=22</div><div>meta-shr/classes/rm=5Fold=5Fwork.b=
bclass:</div><div>WORKDIR =3D =22=24=7BTMPDIR=7D/work/=24=7BMULTIMACH=5FT=
ARGET=5FSYS=7D/=24=7BPN=7D/=24=7BP=46=7D=22</div><div>meta-micro/classes/=
rm=5Fold=5Fwork.bbclass:</div><div>WORKDIR =3D =22=24=7BTMPDIR=7D/work/=24=
=7BMULTIMACH=5FTARGET=5FSYS=7D/=24=7BPN=7D/=24=7BEXTENDPE=7D=24=7BPV=7D-=24=
=7BPR=7D=22</div><div><br></div><div>Cheers,</div><div><br></div><blockqu=
ote type=3D=22cite=22><div><div><br></div><blockquote type=3D=22cite=22><=
blockquote type=3D=22cite=22><div><div>Regards,</div><div>Kai</div><div><=
br></div><blockquote type=3D=22cite=22><div><div>If get WORKDIR in this w=
ay, I'll update the script with no argument</div><div>because the argumen=
t is useless to identify the WORKDIR.</div><div><br></div><div>Regards,</=
div><div>Kai</div><blockquote type=3D=22cite=22><div><div>since you alrea=
dy call into bitbake in the script in question.</div><div><br></div><div>=
Cheers,</div><div><br></div><div>Richard</div></div></blockquote><div><br=
></div><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F</div><div>bitbake-devel mailing list</div><div><a href=3D=22mailto:bi=
tbake-devel=40lists.openembedded.org=22>bitbake-devel=40lists.openembedde=
d.org</a></div><div><a href=3D=22http://lists.linuxtogo.org/cgi-bin/mailm=
an/listinfo/bitbake-devel=22>http://lists.linuxtogo.org/cgi-bin/mailman/l=
istinfo/bitbake-devel</a></div></div></blockquote><div><br></div><div>=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F</div><div=
>bitbake-devel mailing list</div><div><a href=3D=22mailto:bitbake-devel=40=
lists.openembedded.org=22>bitbake-devel=40lists.openembedded.org</a></div=
><div><a href=3D=22http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bi=
tbake-devel=22>http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbak=
e-devel</a></div></div></blockquote></blockquote></div></blockquote><div>=
<br></div><div>-- </div><div>Martin 'JaMa' Jansa     jabber: <a href=3D=22=
mailto:Martin.Jansa=40gmail.com=22>Martin.Jansa=40gmail.com</a></div></di=
v></blockquote><div><br></div><div><br></div><div><br></div><blockquote t=
ype=3D=22cite=22><div><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F</div><div>bitbake-devel mailing list</div><div><a href=
=3D=22mailto:bitbake-devel=40lists.openembedded.org=22>bitbake-devel=40li=
sts.openembedded.org</a></div><div><a href=3D=22http://lists.linuxtogo.or=
g/cgi-bin/mailman/listinfo/bitbake-devel=22>http://lists.linuxtogo.org/cg=
i-bin/mailman/listinfo/bitbake-devel</a></div></div></blockquote></div></=
blockquote><div><br></div><div>-- </div><div>Martin 'JaMa' Jansa     jabb=
er: <a href=3D=22mailto:Martin.Jansa=40gmail.com=22>Martin.Jansa=40gmail.=
com</a></div></div></blockquote><div><br></div><div><br></div><div><br></=
div><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
</div><div>bitbake-devel mailing list</div><div><a href=3D=22mailto:bitba=
ke-devel=40lists.openembedded.org=22>bitbake-devel=40lists.openembedded.o=
rg</a></div><div><a href=3D=22http://lists.linuxtogo.org/cgi-bin/mailman/=
listinfo/bitbake-devel=22>http://lists.linuxtogo.org/cgi-bin/mailman/list=
info/bitbake-devel</a></div></div></div></span>
                =20
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            

--4f67a726_515f007c_aa0--
