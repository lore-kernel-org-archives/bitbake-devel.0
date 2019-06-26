Return-Path: <jaymin.linux@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id AF9706C230
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 05:04:41 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id i2so727983plt.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jun 2019 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=jyc6cFlLP4CmvbeNs165hUzYMIq+66GLUeQdkRgkAA8=;
	b=kIykwjOJ2JqkvDNRFG4ta4e5U0S5yebeRa0xuy9GiGlmelK6eOp9ZdOhM4BtpvLjl+
	Z0JXGCxxPOFrrHoAO3WEoNR4mtz4/YfQI67AquoBkwD1Mztcti22rcOlci+trMG32/fz
	d9kBTXEfC7jaYa2fZPKiGf/I48lvPH7ijg0GC+vN5lpJFjO/L+n9mQybA1UI2qwdx4Fi
	R4+ALvXKyOnA72eMj4FCelcQAe9O7hjYEpxBFYQrsOygCdN1Tmr7/RPjfPTGbCiqmylB
	7jo7canAqsemTNrl784um0G+ymjrTdIlADOPIkvAWRWmJwMSI8AVwf0dDs/tc06lxamo
	RKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=jyc6cFlLP4CmvbeNs165hUzYMIq+66GLUeQdkRgkAA8=;
	b=DWlRPoR1U+pHyZrQcSvWetj/09TamFcfLFJ1RpMDp0kyogY/eBEUN7pqwl/iyw0+kV
	tfgtJQ9EtLoFtp0UPPcb4bKrOnp72OcMduP82SKkzYvImiksYky63slpLu+6O7u/hXxq
	UjcCTLjalE2xv+3xyyzd08WKJP249yUb8WS/650gx/OeRhJS0iUd3+dA+Wd8HBeykzP0
	K9q2rSxrcTat9YUfOi7b0ZorQrYrtlnVjjiQtTBdJFjCqeIs77FJVLYxfYjSVnuj85vo
	2K8B1Jk+O4BoJwFYk18EGI54SszQlLsdXN7fRmgkolTknP0WyCFgOjZzzNovSIC9vGDS
	gU9g==
X-Gm-Message-State: APjAAAV9PhFB+6VQOf27C3chiIXA3u0c7bC1HOQLB+F6cDjfVXwrQ43C
	6Fn+ewBe20pVfvMYoAMq6kuJ5fFz3QVV1tcvWscc8z2C
X-Google-Smtp-Source: APXvYqy1G5Ldhk6b2YYNv8WiSoXsSmyoEBxWFl2ui1p9q1B/jEprktKqV6kcChRv06t/bgemJyt0Tuc76Ogj+ol59wg=
X-Received: by 2002:a17:902:403:: with SMTP id 3mr2968895ple.66.1561525482418; 
	Tue, 25 Jun 2019 22:04:42 -0700 (PDT)
MIME-Version: 1.0
From: Jaymin D <jaymin.linux@gmail.com>
Date: Wed, 26 Jun 2019 10:34:31 +0530
Message-ID: <CAL02zyvgmHi-SPqvmaTRUeJ-bgEy3ehaR06raVNXT6=8gFbnLw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Bitbake Error in quilt-native_0.64.bb
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
X-List-Received-Date: Wed, 26 Jun 2019 05:04:41 -0000
Content-Type: multipart/alternative; boundary="000000000000aff618058c32fbc3"

--000000000000aff618058c32fbc3
Content-Type: text/plain; charset="UTF-8"

Facing error as below while doing bitbake in fresh source. Earlier, I have
build image successfully on the host machine.
But, after cleaning when I have started building the image again, facing
below error on the same environment (Ubuntu 16.04 LTS) on the host machine.

The stack trace of python calls that resulted in this exception/failure was:
File: 'relocatable_binaries_preprocess', lineno: 6, function: <module>
     0002:def relocatable_binaries_preprocess(d):
     0003:
 rpath_replace(d.expand('/poky/build/tmp-glibc/work/x86_64-linux/quilt-native/0.64-r0/sysroot-destdir/'),
d)
     0004:
     0005:
 *** 0006:relocatable_binaries_preprocess(d)
     0007:
File: 'relocatable_binaries_preprocess', lineno: 3, function:
relocatable_binaries_preprocess
     0001:
     0002:def relocatable_binaries_preprocess(d):
 *** 0003:
 rpath_replace(d.expand('/poky/build/tmp-glibc/work/x86_64-linux/quilt-native/0.64-r0/sysroot-destdir/'),
d)
     0004:
     0005:
     0006:relocatable_binaries_preprocess(d)
     0007:
File: 'chrpath.bbclass', lineno: 7, function: rpath_replace
     0003:
     0004:    for bindir in bindirs:
     0005:        #bb.note ("Processing directory " + bindir)
     0006:        directory = path + "/" + bindir
 *** 0007:        process_dir (path, directory, d)
     0008:
File: 'chrpath.bbclass', lineno: 44, function: process_dir
     0040:                perms = None
     0041:            else:
     0042:                # Temporarily make the file writeable so we can
chrpath it
     0043:                os.chmod(fpath, perms|stat.S_IRWXU)
 *** 0044:            process_file(cmd, fpath, rootdir, baseprefix, tmpdir,
d)
     0045:
     0046:            if perms:
     0047:                os.chmod(fpath, perms)
     0048:
File: 'chrpath.bbclass', lineno: 4, function: process_file_linux
     0001:def process_file_linux(cmd, fpath, rootdir, baseprefix, tmpdir,
d):
     0002:    import subprocess as sub
     0003:
 *** 0004:    p = sub.Popen([cmd, '-l',
fpath],stdout=sub.PIPE,stderr=sub.PIPE)
     0005:    err, out = p.communicate()
     0006:    # If returned succesfully, process stderr for results
     0007:    if p.returncode != 0:
     0008:        return
File: '/usr/lib/python2.7/subprocess.py', lineno: 711, function: __init__
     0707:                                cwd, env, universal_newlines,
     0708:                                startupinfo, creationflags,
shell, to_close,
     0709:                                p2cread, p2cwrite,
     0710:                                c2pread, c2pwrite,
 *** 0711:                                errread, errwrite)
     0712:        except Exception:
     0713:            # Preserve original exception in case os.close raises.
     0714:            exc_type, exc_value, exc_trace = sys.exc_info()
     0715:
File: '/usr/lib/python2.7/subprocess.py', lineno: 1343, function:
_execute_child
     1339:                except OSError as e:
     1340:                    if e.errno != errno.ECHILD:
     1341:                        raise
     1342:                child_exception = pickle.loads(data)
 *** 1343:                raise child_exception
     1344:
     1345:
     1346:        def _handle_exitstatus(self, sts,
_WIFSIGNALED=os.WIFSIGNALED,
     1347:                _WTERMSIG=os.WTERMSIG, _WIFEXITED=os.WIFEXITED,
Exception: OSError: [Errno 2] No such file or directory

Any solutions?
-- 
Regards
- JAYMIN DABHI

--000000000000aff618058c32fbc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Facing error as below while doing bitbake in fresh so=
urce. Earlier, I have build image successfully on the host machine.</div><d=
iv>But, after cleaning when I have started building the image again, facing=
 below error on the same environment (Ubuntu 16.04 LTS) on the host machine=
.<br></div><div><div><div style=3D"margin-left:40px"><br></div><div style=
=3D"margin-left:40px">The stack trace of python calls that resulted in this=
 exception/failure was:<br>File: &#39;relocatable_binaries_preprocess&#39;,=
 lineno: 6, function: &lt;module&gt;<br>=C2=A0 =C2=A0 =C2=A00002:def reloca=
table_binaries_preprocess(d):<br>=C2=A0 =C2=A0 =C2=A00003: =C2=A0 =C2=A0rpa=
th_replace(d.expand(&#39;/poky/build/tmp-glibc/work/x86_64-linux/quilt-nati=
ve/0.64-r0/sysroot-destdir/&#39;), d)<br>=C2=A0 =C2=A0 =C2=A00004:<br>=C2=
=A0 =C2=A0 =C2=A00005:<br>=C2=A0*** 0006:relocatable_binaries_preprocess(d)=
<br>=C2=A0 =C2=A0 =C2=A00007:<br>File: &#39;relocatable_binaries_preprocess=
&#39;, lineno: 3, function: relocatable_binaries_preprocess<br>=C2=A0 =C2=
=A0 =C2=A00001:<br>=C2=A0 =C2=A0 =C2=A00002:def relocatable_binaries_prepro=
cess(d):<br>=C2=A0*** 0003: =C2=A0 =C2=A0rpath_replace(d.expand(&#39;/poky/=
build/tmp-glibc/work/x86_64-linux/quilt-native/0.64-r0/sysroot-destdir/&#39=
;), d)<br>=C2=A0 =C2=A0 =C2=A00004:<br>=C2=A0 =C2=A0 =C2=A00005:<br>=C2=A0 =
=C2=A0 =C2=A00006:relocatable_binaries_preprocess(d)<br>=C2=A0 =C2=A0 =C2=
=A00007:<br>File: &#39;chrpath.bbclass&#39;, lineno: 7, function: rpath_rep=
lace<br>=C2=A0 =C2=A0 =C2=A00003:<br>=C2=A0 =C2=A0 =C2=A00004: =C2=A0 =C2=
=A0for bindir in bindirs:<br>=C2=A0 =C2=A0 =C2=A00005: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#bb.note (&quot;Processing directory &quot; + bindir)<br>=C2=A0 =C2=
=A0 =C2=A00006: =C2=A0 =C2=A0 =C2=A0 =C2=A0directory =3D path + &quot;/&quo=
t; + bindir<br>=C2=A0*** 0007: =C2=A0 =C2=A0 =C2=A0 =C2=A0process_dir (path=
, directory, d)<br>=C2=A0 =C2=A0 =C2=A00008:<br>File: &#39;chrpath.bbclass&=
#39;, lineno: 44, function: process_dir<br>=C2=A0 =C2=A0 =C2=A00040: =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perms =3D None<br>=C2=A0 =
=C2=A0 =C2=A00041: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>=C2=A0=
 =C2=A0 =C2=A00042: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# Temporarily make the file writeable so we can chrpath it<br>=C2=A0 =C2=A0=
 =C2=A00043: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.chmo=
d(fpath, perms|stat.S_IRWXU)<br>=C2=A0*** 0044: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0process_file(cmd, fpath, rootdir, baseprefix, tmpdir, d)<br>=
=C2=A0 =C2=A0 =C2=A00045:<br>=C2=A0 =C2=A0 =C2=A00046: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if perms:<br>=C2=A0 =C2=A0 =C2=A00047: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.chmod(fpath, perms)<br>=C2=A0 =
=C2=A0 =C2=A00048:<br>File: &#39;chrpath.bbclass&#39;, lineno: 4, function:=
 process_file_linux<br>=C2=A0 =C2=A0 =C2=A00001:def process_file_linux(cmd,=
 fpath, rootdir, baseprefix, tmpdir, d):<br>=C2=A0 =C2=A0 =C2=A00002: =C2=
=A0 =C2=A0import subprocess as sub<br>=C2=A0 =C2=A0 =C2=A00003:<br>=C2=A0**=
* 0004: =C2=A0 =C2=A0p =3D sub.Popen([cmd, &#39;-l&#39;, fpath],stdout=3Dsu=
b.PIPE,stderr=3Dsub.PIPE)<br>=C2=A0 =C2=A0 =C2=A00005: =C2=A0 =C2=A0err, ou=
t =3D p.communicate()<br>=C2=A0 =C2=A0 =C2=A00006: =C2=A0 =C2=A0# If return=
ed succesfully, process stderr for results<br>=C2=A0 =C2=A0 =C2=A00007: =C2=
=A0 =C2=A0if p.returncode !=3D 0:<br>=C2=A0 =C2=A0 =C2=A00008: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return<br>File: &#39;/usr/lib/python2.7/subprocess.py&#39;=
, lineno: 711, function: __init__<br>=C2=A0 =C2=A0 =C2=A00707: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0cwd, env, universal_newlines,<br>=C2=A0 =C2=A0 =
=C2=A00708: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0startupinfo, creationflags,=
 shell, to_close,<br>=C2=A0 =C2=A0 =C2=A00709: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p2cread, p2cwrite,<br>=C2=A0 =C2=A0 =C2=A00710: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0c2pread, c2pwrite,<br>=C2=A0*** 0711: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0errread, errwrite)<br>=C2=A0 =C2=A0 =C2=A00712: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0except Exception:<br>=C2=A0 =C2=A0 =C2=A00713: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Preserve original exception in case os.=
close raises.<br>=C2=A0 =C2=A0 =C2=A00714: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0exc_type, exc_value, exc_trace =3D sys.exc_info()<br>=C2=A0 =C2=
=A0 =C2=A00715:<br>File: &#39;/usr/lib/python2.7/subprocess.py&#39;, lineno=
: 1343, function: _execute_child<br>=C2=A0 =C2=A0 =C2=A01339: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except OSError as e:<br>=C2=A0 =
=C2=A0 =C2=A01340: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if e.errno !=3D errno.ECHILD:<br>=C2=A0 =C2=A0 =C2=A01341: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0raise<br>=C2=A0 =C2=A0 =C2=A01342: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0child_exception =3D pickle.loads(data)<br>=C2=A0*** 13=
43: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise child_exce=
ption<br>=C2=A0 =C2=A0 =C2=A01344:<br>=C2=A0 =C2=A0 =C2=A01345:<br>=C2=A0 =
=C2=A0 =C2=A01346: =C2=A0 =C2=A0 =C2=A0 =C2=A0def _handle_exitstatus(self, =
sts, _WIFSIGNALED=3Dos.WIFSIGNALED,<br>=C2=A0 =C2=A0 =C2=A01347: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_WTERMSIG=3Dos.WTERMSIG, _WIFE=
XITED=3Dos.WIFEXITED,<br>Exception: OSError: [Errno 2] No such file or dire=
ctory<br></div><br clear=3D"all"></div><div>Any solutions?<br></div><div>--=
 <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><=
div><font face=3D"arial, helvetica, sans-serif">Regards<br></font></div><fo=
nt face=3D"arial, helvetica, sans-serif">- JAYMIN DABHI</font></div></div><=
/div></div></div></div></div></div></div></div>

--000000000000aff618058c32fbc3--
