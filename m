Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
	[209.85.215.177])
	by mail.openembedded.org (Postfix) with ESMTP id 44B1360D75
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2013 13:23:31 +0000 (UTC)
Received: by mail-ea0-f177.google.com with SMTP id n15so4373764ead.22
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2013 05:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=j4B7m1hMubDwavoTUh7ixDpvannNXKZnlLCAdD6vRxw=;
	b=yDIF2e9weU7XwX30LPnATxt/TXLMOO8QJDbDgj2Q23Y1atULsHsqgSRw3ZMTAL36dv
	z/qzzqy9KZOlEp7PutRGu/MW57J3KAsFwkQgWf4CqSLrNShECUg6JRfe+9fcKkLdaJVI
	0+N0q/sQ/gcX8TWKu/k4Ffejbb2qqVJcxl24GPEF04YPZMWUXTGd1QAimgm4E9J31khf
	zfjZ1rsuMM905N1gC+VkJ4Na8EC8x7r9FUZ44S4gJsrxuCFKP++fgFRCIJ6S0XChlOdo
	FTrAZoDUEEYJBCzMhRkYT/A5TW/XZ5KOOT0NMdINhEOM8uYP/mvdhsISM3BKmJUhgAuL
	Ml5g==
X-Received: by 10.15.65.1 with SMTP id p1mr2373107eex.108.1388237011577;
	Sat, 28 Dec 2013 05:23:31 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107]) by mx.google.com with ESMTPSA id
	z42sm90646842eeo.17.2013.12.28.05.23.30 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 28 Dec 2013 05:23:30 -0800 (PST)
Date: Sat, 28 Dec 2013 14:24:13 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20131228132413.GB3706@jama>
References: <1387383687.6402.49.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1387383687.6402.49.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Sat, 28 Dec 2013 13:23:32 -0000
X-Groupsio-MsgNum: 4260
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ohz8t0v+ZTQEWKa"
Content-Disposition: inline

--1Ohz8t0v+ZTQEWKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie wrote:
> Its useful to understand where the delta starts against an existing sstat=
e cache
> for a given target. Adding this to the output of the -S option seems like=
 a=20
> natural fit.
>=20
> We use the hashvalidate function to figure this out and assume it can fin=
d siginfo
> files for more than just the setscene tasks.

I haven't tried to find smaller reproducer or exact part of code where
it happends, but in bigger builds I have it fails with

I'll try to reproduce and narrow it a bit, but if you have tip where
to look first..

IndexError: list index out of range:

NOTE: Reparsing files to collect dependency data

    >                self.write_diffscenetasks(invalidtasks)
                     self.state =3D runQueueComplete
  File "/OE/webos/owub/build-starfish-master/bitbake/lib/bb/runqueue.py", l=
ine 1227, in RunQueue.write_diffscenetasks(invalidtasks=3Dset([16694, 11264=
, 5803, 4100, 2054, 16391, 2060, 16, 14354, 4115, 22, 14360, 6148, 8218, 20=
75, 10268, 13658, 8224, 4130, 18467, 16421, 38, 2087, 10283, 6188, 18687, 4=
145, 6194, 12686, 2105, 10298, 12347, 62, 14399, 4160, 12353, 16452, 14406,=
 7231, 6218, 13312, 77, 6224, 2130, 83, 14421, 4184, 15756, 4190, 6239, 214=
5, 98, 10939, 14436, 10598, 2151, 8296, 4202, 8302, 11665, 6257, 6163, 1676=
3, 14949, 123, 4220, 14461, 2175, 10368, 129, 14468, 2181, 8326, 6849, 1250=
7, 16748, 4235, 6286, 10383, 14480, 13336, 146, 8341, 10390, 10391, 4250, 6=
302, 161, 14498, 2211, 8357, 11735, 16552, 4265, 8363, 6316, 8562, 12462, 1=
0415, 14513, 2226, 10421, 16567, 8378, 4283, 4286, 8565, 5152, 10436, 14710=
, 12486, 4295, 200, 8393, 2250, 16588, 12322, 206, 14543, 10452, 6357, 4310=
, 8408, 6363, 221, 14558, 2272, 7888, 10619, 6375, 17623, 12522, 14375, 104=
76, 4334, 2287, 8432, 16784, 16627, 18677, 8438, 16633, 4349, 2302, 17409, =
10497, 6402, 4355, 7851, 13697, 6408, 12554, 268, 2317, 8462, 13357, 13818,=
 8468, 16376, 14650, 16663, 6424, 283, 2332, 15823, 10528, 8483, 16648, 643=
9, 2347, 16192, 4401, 8498, 14644, 6454, 10552, 313, 14023, 7903, 9285, 851=
3, 2371, 6469, 13718, 14741, 2377, 16446, 14668, 10573, 4431, 337, 6484, 12=
629, 343, 11741, 16733, 4446, 8544, 14689, 6499, 2404, 358, 1425, 10604, 12=
656, 6514, 2419, 8254, 374, 6889, 12692, 14665, 5183, 8574, 12671, 6529, 24=
34, 16107, 389, 4487, 2440, 4493, 8590, 14735, 6331, 10644, 405, 406, 2455,=
 6553, 4508, 8605, 3141, 420, 12709, 2470, 10667, 17938, 8621, 6574, 12153,=
 4532, 10313, 4379, 16825, 4538, 6559, 444, 6589, 13381, 7584, 450, 14787, =
2500, 8645, 17814, 10697, 8651, 6604, 8269, 4562, 2515, 16856, 10713, 474, =
6620, 477, 13733, 12291, 14817, 4578, 12710, 4584, 2539, 12370, 12382, 1483=
2, 2545, 498, 12371, 501, 4599, 8696, 15444, 8814, 6653, 510, 14847, 6656, =
2561, 12033, 6665, 8714, 8717, 2575, 10328, 4629, 535, 8728, 7599, 18567, 5=
41, 2590, 12831, 6689, 9307, 4645, 8742, 6695, 14888, 7943, 556, 2605, 1758=
4, 7262, 6710, 12855, 12724, 571, 10813, 14910, 15991, 10821, 2630, 16823, =
2636, 4685, 17273, 15459, 596, 8789, 10838, 10839, 15460, 12891, 4700, 1068=
2, 16300, 13111, 14955, 613, 11068, 2664, 619, 6764, 16146, 2670, 6770, 882=
0, 5566, 14970, 9663, 2685, 13251, 3861, 4736, 6786, 643, 12932, 10006, 149=
85, 7523, 10893, 4751, 658, 12947, 10900, 14038, 15000, 12740, 8859, 2716, =
6815, 8865, 674, 10915, 12093, 10353, 14108, 13426, 689, 12978, 2740, 15030=
, 695, 8889, 2746, 4795, 8895, 4801, 710, 2761, 10954, 13004, 13005, 8910, =
8529, 4816, 13971, 15060, 6873, 13019, 735, 10976, 2785, 16507, 10822, 741,=
 8934, 2791, 4841, 16528, 13035, 15084, 8943, 8946, 12755, 9777, 5588, 4858=
, 6271, 8956, 15146, 11007, 2816, 12416, 15106, 772, 2822, 16513, 4873, 692=
2, 9687, 11022, 4879, 6928, 15121, 787, 2837, 14620, 13080, 17348, 8666, 48=
94, 12779, 802, 2852, 11047, 6952, 7644, 9002, 9003, 15090, 11053, 6621, 13=
104, 817, 2868, 4918, 6967, 13112, 5940, 17690, 4924, 14772, 832, 9026, 154=
99, 9029, 15176, 17483, 2891, 10262, 15182, 847, 13136, 6997, 15161, 4954, =
12431, 15197, 862, 2912, 13153, 9062, 4969, 877, 10767, 10728, 7029, 11128,=
 4985, 7038, 2943, 13184, 7041, 6635, 9093, 902, 13191, 5000, 15243, 908, 1=
1153, 17300, 11159, 5016, 5017, 15258, 9117, 13215, 2976, 7075, 933, 5031, =
15273, 9132, 8690, 2991, 7090, 15435, 948, 11189, 16603, 5047, 7096, 3003, =
957, 16467, 4939, 11204, 5062, 7111, 9162, 971, 3021, 15312, 12785, 5077, 7=
126, 17368, 9177, 986, 3036, 7674, 9183, 11234, 5092, 7141, 1001, 16799, 30=
51, 9199, 11249, 5107, 7157, 1016, 3066, 12117, 9216, 10752, 7171, 15364, 1=
7765, 3081, 5131, 9228, 12446, 1040, 5137, 7186, 11696, 15380, 3096, 11289,=
 9243, 2906, 13342, 1056, 15392, 1062, 3111, 7210, 9261, 11311, 7216, 15410=
, 13402, 1078, 17615, 5177, 14799, 16709, 11326, 3135, 16483, 9056, 11098, =
1093, 9291, 7246, 10083, 13396, 1109, 11350, 5208, 9991, 4623, 11356, 3165,=
 5214, 16229, 3171, 1124, 16406, 15474, 9322, 8039, 5229, 13501, 3186, 1139=
, 8835, 16006, 13432, 9337, 15551, 5244, 10773, 1156, 1157, 7302, 13447, 32=
10, 5259, 11478, 1171, 7317, 13462, 9367, 7320, 3225, 5274, 15515, 3231, 15=
521, 11426, 16582, 9383, 5289, 7340, 7341, 13486, 6041, 7973, 1202, 9398, 3=
255, 5304, 15545, 7355, 3261, 18557, 15221, 1218, 12815, 13510, 11463, 1351=
3, 7372, 7373, 12316, 9423, 11596, 3285, 5334, 2937, 1242, 3291, 11083, 124=
8, 13538, 9445, 5350, 17639, 7402, 13863, 15596, 3309, 11502, 14704, 9460, =
6064, 1273, 13562, 15611, 5374, 12501, 11520, 13569, 9475, 9430, 11526, 538=
3, 3336, 5386, 15575, 1294, 10797, 5395, 11541, 7447, 3352, 3354, 9499, 130=
9, 13598, 15237, 5410, 7387, 11556, 7477, 7462, 7729, 3368, 9514, 16022, 11=
571, 1333, 13622, 15672, 9529, 1339, 13628, 11296, 9535, 3392, 5441, 7493, =
3398, 15687, 13643, 8774, 9550, 8024, 11602, 1363, 7508, 3413, 15702, 13881=
, 5466, 5472, 11617, 7820, 1379, 3428, 15590, 9575, 13673, 17770, 13276, 54=
87, 1394, 3443, 17784, 14247, 11643, 7548, 9597, 3648, 1410, 10208, 13703, =
17644, 11658, 3467, 9612, 5518, 3473, 15762, 11667, 14871, 14574, 12800, 14=
31, 9627, 3488, 16283, 7750, 1447, 11690, 15787, 5550, 3503, 5552, 15793, 9=
651, 9660, 13757, 3518, 1471, 15808, 13763, 7623, 9672, 12876, 17868, 7629,=
 1486, 14575, 14017, 5585, 13778, 1492, 11711, 3542, 7417, 3548, 5597, 1322=
1, 17888, 13793, 10960, 9702, 15848, 7659, 5612, 1517, 253, 11371, 3572, 97=
17, 11766, 6740, 3578, 5627, 11772, 1533, 15870, 13824, 1539, 9732, 3593, 5=
642, 11787, 15885, 13839, 1554, 9747, 5654, 15961, 3608, 7705, 11802, 11183=
, 17948, 1569, 9762, 17958, 3623, 5672, 11441, 14599, 15916, 9138, 7554, 12=
88, 11829, 7735, 13236, 15931, 15285, 1600, 5697, 11844, 14262, 3654, 13896=
, 12215, 13902, 9807, 5712, 11859, 7765, 5718, 1624, 11865, 17679, 16177, 1=
3917, 1630, 10853, 955, 5733, 9831, 16316, 13932, 7789, 1646, 11889, 15635,=
 5748, 3701, 9846, 11895, 13947, 7804, 4715, 3716, 1670, 11911, 9864, 18028=
, 3722, 1676, 18061, 9870, 12568, 7826, 10558, 4718, 11926, 15741, 13977, 1=
3050, 5787, 9885, 16034, 3747, 1701, 3753, 1707, 9901, 11950, 5809, 14002, =
14605, 16052, 3765, 12916, 1722, 9916, 17354, 15717, 7873, 15947, 11972, 18=
038, 3783, 1737, 9931, 16076, 15650, 5840, 3798, 9946, 16091, 11996, 14925,=
 5855, 13592, 1761, 12002, 18644, 3814, 1767, 9961, 12583, 5870, 10877, 156=
56, 12018, 3828, 14069, 7928, 16122, 1792, 9985, 3843, 14084, 5895, 16140, =
7949, 1807, 12048, 7698, 5763, 1813, 5910, 3864, 17028, 5916, 12063, 3873, =
16162, 1829, 11228, 7979, 12078, 3888, 14129, 1844, 5944, 15327, 5949, 1004=
6, 3903, 14144, 7277, 8003, 1860, 12598, 14756, 5961, 12269, 13282, 3918, 1=
4159, 17720, 8018, 10068, 1877, 5976, 16217, 3933, 14174, 15333, 16226, 543=
5, 12132, 1893, 5991, 13065, 16362, 10098, 12147, 1908, 3957, 8054, 14199, =
10160, 3963, 16253, 6015, 1923, 8069, 14216, 12169, 10123, 16268, 14222, 60=
31, 1938, 3987, 8084, 6039, 12184, 3993, 10139, 17591, 12613, 1953, 9792, 1=
3297, 4008, 6812, 10154, 8108, 1968, 12209, 8114, 6070, 4425, 14268, 16317,=
 12861, 1983, 4033, 8130, 6085, 12230, 4039, 8727, 10185, 14283, 1998, 1019=
3, 10194, 12963, 16340, 12245, 4055, 16346, 6112, 8163, 14308, 4069, 6118, =
2023, 12547, 14314, 15015, 18071, 2029, 10223, 7569, 8178, 6133, 14327, 408=
8, 4091, 16844, 12285, 10238])):
                 matches =3D {k : v for k, v in matches.iteritems() if h no=
t in k}
    >            latestmatch =3D sorted(matches.keys(), key=3Dlambda f: mat=
ches[f])[-1]
                 prevh =3D __find_md5__.search(latestmatch).group(0)
IndexError: list index out of range

>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 428cff1..b7a602b 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1039,6 +1039,7 @@ class RunQueue:
> =20
>          if self.state is runQueueSceneInit:
>              if self.cooker.configuration.dump_signatures:
> +                self.print_diffscenetasks()
>                  self.dump_signatures()
>              else:
>                  self.start_worker()
> @@ -1123,6 +1124,82 @@ class RunQueue:
> =20
>          return
> =20
> +    def print_diffscenetasks(self):
> +
> +        valid =3D []
> +        sq_hash =3D []
> +        sq_hashfn =3D []
> +        sq_fn =3D []
> +        sq_taskname =3D []
> +        sq_task =3D []
> +        noexec =3D []
> +        stamppresent =3D []
> +        valid_new =3D set()
> +
> +        for task in xrange(len(self.rqdata.runq_fnid)):
> +            fn =3D self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[t=
ask]]
> +            taskname =3D self.rqdata.runq_task[task]
> +            taskdep =3D self.rqdata.dataCache.task_deps[fn]
> +
> +            if 'noexec' in taskdep and taskname in taskdep['noexec']:
> +                noexec.append(task)
> +                continue
> +
> +            sq_fn.append(fn)
> +            sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
> +            sq_hash.append(self.rqdata.runq_hash[task])
> +            sq_taskname.append(taskname)
> +            sq_task.append(task)
> +        call =3D self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashf=
n, d)"
> +        locs =3D { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" :=
 sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
> +        valid =3D bb.utils.better_eval(call, locs)
> +        for v in valid:
> +            valid_new.add(sq_task[v])
> +
> +        # Tasks which are both setscene and noexec never care about depe=
ndencies
> +        # We therefore find tasks which are setscene and noexec and mark=
 their
> +        # unique dependencies as valid.
> +        for task in noexec:
> +            if task not in self.rqdata.runq_setscene:
> +                continue
> +            for dep in self.rqdata.runq_depends[task]:
> +                hasnoexecparents =3D True
> +                for dep2 in self.rqdata.runq_revdeps[dep]:
> +                    if dep2 in self.rqdata.runq_setscene and dep2 in noe=
xec:
> +                        continue
> +                    hasnoexecparents =3D False
> +                    break
> +                if hasnoexecparents:
> +                    valid_new.add(dep)
> +
> +        invalidtasks =3D set()
> +        for task in xrange(len(self.rqdata.runq_fnid)):
> +            if task not in valid_new and task not in noexec:
> +                invalidtasks.add(task)
> +
> +        found =3D set()
> +        processed =3D set()
> +        for task in invalidtasks:
> +            toprocess =3D set([task])
> +            while toprocess:
> +                next =3D set()
> +                for t in toprocess:
> +                    for dep in self.rqdata.runq_depends[t]:
> +                        if dep in invalidtasks:
> +                            found.add(task)
> +                        if dep not in processed:
> +                            processed.add(dep)
> +                            next.add(dep)
> +                toprocess =3D next
> +                if task in found:
> +                    toprocess =3D set()
> +
> +        tasklist =3D []
> +        for task in invalidtasks.difference(found):
> +            tasklist.append(self.rqdata.get_user_idstring(task))
> +
> +        if tasklist:
> +            bb.plain("The differences between the current build and any =
cached tasks start at the following tasks:\n" + "\n".join(tasklist))
> =20
>  class RunQueueExecute:
> =20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--1Ohz8t0v+ZTQEWKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlK+0P0ACgkQN1Ujt2V2gBxdMwCdF2gFGiPPxj87N2r+CYIPgLB5
hMwAn04JpRgXJOyFP5QFEQzoqfeE68fR
=mhDL
-----END PGP SIGNATURE-----

--1Ohz8t0v+ZTQEWKa--
