Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A28C52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 19:56:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web10.55794.1723492571741861074
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 12:56:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=F+DK1nOU;
 spf=pass (domain: axis.com, ip: 40.107.20.54, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcRaZssUG+x9tu201zahV19SusMtVdOeiRoFMo/ZC3YrmV1Al5MqRfTJXBdkWGix4kM4REhBnSV4Ax6WiWnchLplQ1h+8y6S7vLXGTjnUppXYokk7wnlil9brKfpqQzd9mTKojAIssblRxxOPTVBavUTVAAl/IO/AYehXsj+xQI7+i2ZYp+85dXwzjjGBrOtiVCH/sEgB6N4kTwUduUK58CigSPQVof36n7kP3zii9mqYc7MUOrwLXlhaKCiSZ++r5El0vsGUGeEVt6POeFWE2HBOj/W6qq8FQPejwluqA7h9CAXwmmgshl+ilGu2A34aC6KsQpK+cBVgIfRJ5rZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MwPm+aoKFtFrzHezDnK82An2wLilaBhzBNNQS0nAns=;
 b=Zeu6YJnCo1wE7pJa1mE6FXM22dsxlWh92ZauKoadh48H3HCSVCVCYDLkXgdTAEyM3tduoqE/kjigggN4OR4MPlelCHYBLoOFw5V1N449lbxKRxtCBxPrYBqSCS0iYFQo6IqFHVQ8imJ2Rv7yxpSmeaTYCGw7f4ykByod+6g9Y1YGcE270hao5PA3yM43Z7cLzcSbT7hM7y7nNxb8GT2FnGLzvYbMAEbl8LTN3jQHHbzmI3qHdsA+ii3czRAvEDUO0qla00hT8G0Qfs+T1JbeDT+hxqq88JK98AORLTlhEctVfdmybx3bzo0++LVXTMXCbM+oeKSdUnCrNIfmvlKgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MwPm+aoKFtFrzHezDnK82An2wLilaBhzBNNQS0nAns=;
 b=F+DK1nOUzExo8ghiHjqNamlboFkVWTKrDT0/3domrYVq86Ft8hCCpwki4MeQx4rCT/xBWZatwMPYWQ/Q3kimuRuYDGH62HTvjjut5Jj3UC9CeOyUGA0UUIE19slUaocL+Yb/U51r1PiSlVd2E6N5+rHiJkTnqLR0qwf7b8OjhnA=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS2PR02MB9318.eurprd02.prod.outlook.com (2603:10a6:20b:57a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 19:56:08 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 19:56:08 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 3/4] BBHandler/ast: Improve addtask
 handling
Thread-Topic: [bitbake-devel] [PATCH 3/4] BBHandler/ast: Improve addtask
 handling
Thread-Index: AQHa7M/Wh9bV+yI/y0u7lNByq5uwWLIj+mvw
Date: Mon, 12 Aug 2024 19:56:08 +0000
Message-ID: 
 <DB5PR02MB102134738BF9EC9D202B922CFEF852@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
 <20240812155335.904273-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240812155335.904273-3-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS2PR02MB9318:EE_
x-ms-office365-filtering-correlation-id: fd4d176a-0930-4798-d679-08dcbb08ced3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?9H1dj0+e+WvJMEp9/QH2EX0evHE5HAa2CeAY+hIz4Cbbwxs3qFNhrr3ZBW1g?=
 =?us-ascii?Q?/Y1eiiocuhYdSZIx5I4CwW50/9fTvPCEC5KH92MhKyl4vGfxHdlaLeGCvEVn?=
 =?us-ascii?Q?W5yfno2ut3ba7xlTTU/ITioqEpLJ7tj+2A1nw8s84iVVeoXrjL5VDfCLlDzq?=
 =?us-ascii?Q?CVxxfO0lYa9q6KbFVy2nPd0/iuuPlmYqG1V5ZyYs/WNjxGUbj7vLziuNh+7H?=
 =?us-ascii?Q?2AQET1lGJY9XioH9hNyadDYXO6JBaXmS2+nbe8vS1YQlkDqKZNN0sfev4UfK?=
 =?us-ascii?Q?i4vj1TAUj6sDwEdoa34+hqQ0sxpz7MNE4jHStjrvD3HcptmgDEWpdq/w8O5B?=
 =?us-ascii?Q?xtO4CvVLLJ00merdDItpcIkkSIqQIRixpePgivTEieaZBhwvY3RvSZb8YZeS?=
 =?us-ascii?Q?nddnyrGzydyQs3mhnEYfAArV2EjDzz2zjEmiEGXkXRcBPtCzSt/2H7TpzfIu?=
 =?us-ascii?Q?ydhAZz0GdkK5V49r07Mt6bJmwJf4i6K3Cd7oPykO2Wp1FnhuvxK/LrotYxqV?=
 =?us-ascii?Q?NPiS0Myfdak376H7aDqCdSxHRKiB3h5acuVVQRR6QlYggDFQcPL82JTxbjYD?=
 =?us-ascii?Q?WFF+EsORYD2tduYTgA0gjNy+MZQX2tsDx97u90w44C3W+GV0FEmsyXo/HcMz?=
 =?us-ascii?Q?TiNTwEGK/RrSGn6RLwBC4B2aq6seAtObZ1xO118x2bYIceFfrf+dghMFnQGA?=
 =?us-ascii?Q?2nLyzGL5LGS7tAxpoZD9WoTe2zH9ZQL12OiH0R0tXQEJyCVYHb1heD+ciPSh?=
 =?us-ascii?Q?2UvrGQatSNAilwWXJ0gBH3GggI+9KSJ1+76e/t/UQsi3bA1awDAiXURxK/yE?=
 =?us-ascii?Q?ezvvjI2GejAGfIUcgGCr3MkdB72eJcQaZuGmgVcrmZmivBuG6yeOO8xRbLyQ?=
 =?us-ascii?Q?OBHcGXGFRwXGoz7BGNPAqt5Ut3KDM5VT64MY/55TN5mpSVdmUGZRVY0DNxVd?=
 =?us-ascii?Q?FMyuX4Mj45ufthRBNFfW5lGtOWKW7FQOlrdR8aGL9VNwuovJ1c6CjZwYUHnF?=
 =?us-ascii?Q?lH2Tt/+PTWqxiFMPEorTCeOgw+S78V2g1+wmqByG/cbAYEGJcg0QX43qNh7I?=
 =?us-ascii?Q?1WuigDmq+F0DwwCUGImv3FP73J7d1wu+Jzo8H5n45N/rwnxk+r1SvOlQ4psT?=
 =?us-ascii?Q?io/a+5Gs0frDk/fBFY9xGWcYqk7O8XE9kY7piJ0VE4BEx5ACrf79stQu4jDM?=
 =?us-ascii?Q?hon1oZIW9IXL1PfDoSl9Ya37MhtOv/7zaQjNJ5x1WZak5F2TXETGgN0hd7Dh?=
 =?us-ascii?Q?/CAb/CKgDICSlzekoDkt5siv7NQO17RLViTPG4o0LjMKGyoyhbaXIZuOBEDK?=
 =?us-ascii?Q?4gA7ecBPqQqEMEi953z9Wnco373yhWl0TuxPtyu8T7cs+g3Q0vY1/DbEFjrJ?=
 =?us-ascii?Q?iaROwnNaqzwvtMeYMohkhHMIUWRJ1jzWMTeeXwOnGnvNIMhtGA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?T4+oyhvAV8KlGoBacNaiqyRYtqVvHxUcu7CrPvLGs8UIsskblb+C78uPF7ti?=
 =?us-ascii?Q?uj+gj9ijsBnUBN2mPoKLt69okjRkOcPKWqUi380T1FtDn0xdz6o4ZRMpsV3O?=
 =?us-ascii?Q?AiMzilk21joWLgMUe7jz8zvR9yrcEy7CV/ovUCO+14c6ZP3fa8Dx+ZEPutQp?=
 =?us-ascii?Q?zojfMoSVusIC3RnOPtFP9Tw7+GSQQPS/O09HhhDtTcpG1ny3eR7GWpJgsYCN?=
 =?us-ascii?Q?rCHbMJyfDQVkryjmWMK1MOf5rXZ9qE5W3QmBHz09lRqrQQijvs0fqnR462sp?=
 =?us-ascii?Q?htr+q5Ewhk+rxCd9A3+lf6o4A/vkxIe5EjqvpXjSLe5mTmt6UYEaSD/8GFz2?=
 =?us-ascii?Q?8/gVlv7zF/VuQHDE374PY+LleYpUVz18g4SdJD5mLJOm7iySPcItFYUmWR6x?=
 =?us-ascii?Q?/Fy69OsO+f7F24ScwM43ZpbcN+ifVbfxjGzC/Fu6WpG0XTkT5A4cMHCBi///?=
 =?us-ascii?Q?6KaE0LLOvhBbKXJHq4pang8LzjhttMN0qxX/5kQIcHGlnQgJuNzfnHhYZ3Vn?=
 =?us-ascii?Q?4e4tiDI0sP5SGT2bSHA2OJVoVtZ1Tl9fbksnYR39KBcM1RHDm3n4pvIVlMuN?=
 =?us-ascii?Q?3PXx+Psi/TcItPngEKJIEAH55MuI48rvyL1+W+US0zt4Hdzjcp3WBV1UvQ4d?=
 =?us-ascii?Q?dio3keW6jAsBZ7kWJ+LDT9g9Qa6zv6iOHNqxfJwHj+7pzvSAG/yi8epu8etC?=
 =?us-ascii?Q?QcaLSxgyd2FUeEGHiCp5mMJtNIk5nGIvIACGDNygOHWg/JChAlcsvgt7tYH7?=
 =?us-ascii?Q?2z6dNfed1h4VifXf7TUvkKa24poBm7LD9+u18mkYDI232Im40nc6t8SITWyy?=
 =?us-ascii?Q?vE+pqXbgXGYsb2vmWvMDQn46RYi0ccrvwTOFb4dbYneawqCa59kjILA0GkP9?=
 =?us-ascii?Q?esjdtDLOw8f2xF0lpTRUboh1nuzFHJI5PX1JHa8YDPt9pskNSCrBTIG3ZVry?=
 =?us-ascii?Q?SyaU3wmnR5JJ8D0FNIywlT+oTpSm545N63pKVdzoCBLlgWIVjZ0/M6zI0dGB?=
 =?us-ascii?Q?CrgFOg6BiwW97+lAewTiktAO0acikLpzGQhxk0P5Nh/MjIWnLs7FERxhyxq6?=
 =?us-ascii?Q?X1kmmiOok9hPvWj1QSM/e5H2R26uC+5shSzEozzYpHq/aEQ6prNmEBs4hMoc?=
 =?us-ascii?Q?7+JfGvf0+ReDrXOtNgg3J6xVoaYnbwzACI1ScZMysh8kOU26cymyr+JWn15J?=
 =?us-ascii?Q?Q9dwU/x7xWmisn2kCALCf6Um9+LfLVT4kJqUaLU0mpucwtKA1V0Jd/ofdSq7?=
 =?us-ascii?Q?0S4IW1TyaK3tRTy4iwm6mn0KsuIrvg99V0yhSETt4vMZCU/V96bufp3hydWu?=
 =?us-ascii?Q?9IO7keRaGxn8W/7e1EFn+1lj6dymBx317uTIRnCMs4fNDLzqUFDufW9nbH2Y?=
 =?us-ascii?Q?tvSsFj9erZUtQ+tBJAM3aY2mMBFIWN9tdT05wbGQYjOa2RZYQyaInpY3XsER?=
 =?us-ascii?Q?PhVnNxdaLv7ol/0SfUyRMHG582P5bV2bkkGlrISFYPpAPduU2hMbywQeyoxr?=
 =?us-ascii?Q?F7duNH+OyEoSJ9EJ+SHO7151+34/g2nTOvb+T5QF3ob7enh81J8BINObRVXu?=
 =?us-ascii?Q?FhWGEjPQ8e14YZ1nZro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4d176a-0930-4798-d679-08dcbb08ced3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 19:56:08.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adGTMwfnD+vYLV001GI7KYqUiEs77CBPvyO++7XlW4ctbQFNlvZGXhu1mKXhsYP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9318
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 19:56:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16476

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 12 augusti 2024 17:54
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 3/4] BBHandler/ast: Improve addtask handl=
ing
>=20
> The recent addtask improvement to handle comments complicated the regex s=
ignificantly
> and there are already a number of corner cases in that code which aren't =
handled well.
>=20
> Instead of trying to complicate the regex further, switch to code logic i=
nstead. This
> means the following cases are now handled:
>=20
> * addtask with multiple task names
> * addtask with multiple before constraints
> * addtask with multiple after constraints
>=20
> The testcase is updated to match the improvements.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/parse/ast.py                | 26 +++++++-------------
>  lib/bb/parse/parse_py/BBHandler.py | 38 +++++++++++++++++-------------
>  lib/bb/tests/parse.py              | 15 ++++--------
>  3 files changed, 35 insertions(+), 44 deletions(-)
>=20
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 7581d003fd..001ba8d289 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -240,14 +240,16 @@ class ExportFuncsNode(AstNode):
>                  data.setVar(func, sentinel + "    " + calledfunc + "\n",=
 parsing=3DTrue)
>=20
>  class AddTaskNode(AstNode):
> -    def __init__(self, filename, lineno, func, before, after):
> +    def __init__(self, filename, lineno, tasks, before, after):
>          AstNode.__init__(self, filename, lineno)
> -        self.func =3D func
> +        self.tasks =3D tasks
>          self.before =3D before
>          self.after =3D after
>=20
>      def eval(self, data):
> -        bb.build.addtask(self.func, self.before, self.after, data)
> +        tasks =3D self.tasks.split()
> +        for task in tasks:
> +            bb.build.addtask(task, self.before, self.after, data)
>=20
>  class DelTaskNode(AstNode):
>      def __init__(self, filename, lineno, tasks):
> @@ -348,21 +350,11 @@ def handlePythonMethod(statements, filename, lineno=
, funcname, modulename, body)
>  def handleExportFuncs(statements, filename, lineno, m, classname):
>      statements.append(ExportFuncsNode(filename, lineno, m.group(1), clas=
sname))
>=20
> -def handleAddTask(statements, filename, lineno, m):
> -    func =3D m.group("func")
> -    before =3D m.group("before")
> -    after =3D m.group("after")
> -    if func is None:
> -        return
> -
> -    statements.append(AddTaskNode(filename, lineno, func, before, after)=
)
> -
> -def handleDelTask(statements, filename, lineno, m):
> -    func =3D m.group(1)
> -    if func is None:
> -        return
> +def handleAddTask(statements, filename, lineno, tasks, before, after):
> +    statements.append(AddTaskNode(filename, lineno, tasks, before, after=
))
>=20
> -    statements.append(DelTaskNode(filename, lineno, func))
> +def handleDelTask(statements, filename, lineno, tasks):
> +    statements.append(DelTaskNode(filename, lineno, tasks))
>=20
>  def handleBBHandlers(statements, filename, lineno, m):
>      statements.append(BBHandlerNode(filename, lineno, m.group(1)))
> diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/B=
BHandler.py
> index c1653faeee..87c03e9238 100644
> --- a/lib/bb/parse/parse_py/BBHandler.py
> +++ b/lib/bb/parse/parse_py/BBHandler.py
> @@ -23,7 +23,7 @@ __func_start_regexp__    =3D re.compile(r"(((?P<py>pyth=
on(?=3D(\s|\()))|(?P<fr>faker
>  __inherit_regexp__       =3D re.compile(r"inherit\s+(.+)" )
>  __inherit_def_regexp__   =3D re.compile(r"inherit_defer\s+(.+)" )
>  __export_func_regexp__   =3D re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
> -__addtask_regexp__       =3D re.compile(r"addtask\s+(?P<func>\w+)\s*((be=
fore\s*(?P<before>(([^#\n]*(?=3Dafter))|([^#\n]*))))|(after\s*(?P<after>(([=
^#\n]*(?=3Dbefore))|([^#\n]*)))))*(?P<comment>#.*|.*?)")
> +__addtask_regexp__       =3D re.compile(r"addtask\s+([^#\n]+)(?P<comment=
>#.*|.*?)")
>  __deltask_regexp__       =3D re.compile(r"deltask\s+([^#\n]+)(?P<comment=
>#.*|.*?)")
>  __addhandler_regexp__    =3D re.compile(r"addhandler\s+(.+)" )
>  __def_regexp__           =3D re.compile(r"def\s+(\w+).*:" )
> @@ -239,29 +239,35 @@ def feeder(lineno, s, fn, root, statements, eof=3DF=
alse):
>=20
>      m =3D __addtask_regexp__.match(s)
>      if m:
> -        if len(m.group().split()) =3D=3D 2:
> -            # Check and warn for "addtask task1 task2"
> -            m2 =3D re.match(r"addtask\s+(?P<func>\w+)(?P<ignores>.*)", s=
)
> -            if m2 and m2.group('ignores'):
> -                logger.warning('addtask ignored: "%s"' % m2.group('ignor=
es'))
> -
> -        # Check and warn for "addtask task1 before task2 before task3", =
the
> -        # similar to "after"
> -        taskexpression =3D s.split()
> -        for word in ('before', 'after'):
> -            if taskexpression.count(word) > 1:
> -                logger.warning("addtask contained multiple '%s' keywords=
, only one is supported" % word)
> +        after =3D ""
> +        before =3D ""
> +        tasks =3D m.group(1).split(" before ")[0].split(" after ")[0]
> +
> +        for exp in m.group(1).split(" before "):
> +            exp2 =3D exp.split(" after ")
> +            if len(exp2) > 1:
> +                after =3D after + " ".join(exp2[1:])
> +
> +        for exp in m.group(1).split(" after "):
> +            exp2 =3D exp.split(" before ")
> +            if len(exp2) > 1:
> +                before =3D before + " ".join(exp2[1:])

I found it hard to understand what the code above is actually doing.=20
How about something like this instead (untested):

        cur =3D "tasks"
        tasks =3D {"tasks": [], "before": [], "after": []}
        for task in m.group(1).split():
            if task in ("before", "after"):
                cur =3D task
            else:
                # Check and warn for having a task with a keyword as part o=
f the task name
                if any(("%s_" % keyword) in task for keyword in bb.data_sma=
rt.__setvar_keyword__):
                    raise ParseError("Task name '%s' contains a keyword whi=
ch is not recommended/supported.\nPlease rename the task not to include the=
 keyword.\n%s" % (task, ("\n".join(map(str, bb.data_smart.__setvar_keyword_=
_)))), fn)

                tasks[cur].append(task)

        if tasks["tasks"]:
            ast.handleAddTask(statements, fn, lineno, tasks["tasks"], tasks=
["before"], tasks["after"])
        return

>=20
> -        # Check and warn for having task with exprssion as part of task =
name
> +        # Check and warn for having task with a keyword as part of task =
name
> +        taskexpression =3D s.split()
>          for te in taskexpression:
>              if any( ( "%s_" % keyword ) in te for keyword in bb.data_sma=
rt.__setvar_keyword__ ):
>                  raise ParseError("Task name '%s' contains a keyword whic=
h is not recommended/supported.\nPlease rename the task not to include the =
keyword.\n%s" % (te, ("\n".join(map(str, bb.data_smart.__setvar_keyword__))=
)), fn)
> -        ast.handleAddTask(statements, fn, lineno, m)
> +
> +        if tasks is not None:
> +            ast.handleAddTask(statements, fn, lineno, tasks, before, aft=
er)
>          return
>=20
>      m =3D __deltask_regexp__.match(s)
>      if m:
> -        ast.handleDelTask(statements, fn, lineno, m)
> +        task =3D m.group(1)
> +        if task is not None:
> +            ast.handleDelTask(statements, fn, lineno, task)
>          return
>=20
>      m =3D __addhandler_regexp__.match(s)
> diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> index d076fcc208..97df2c4590 100644
> --- a/lib/bb/tests/parse.py
> +++ b/lib/bb/tests/parse.py
> @@ -177,7 +177,7 @@ python () {
>=20
>      addtask_deltask =3D """
>  addtask do_patch after do_foo after do_unpack before do_configure before=
 do_compile
> -addtask do_fetch do_patch
> +addtask do_fetch2 do_patch2
>=20
>  addtask do_myplaintask
>  addtask do_myplaintask2
> @@ -194,18 +194,11 @@ deltask do_fetch ${MYVAR} ${EMPTYVAR}
>  deltask ${EMPTYVAR}
>  """
>      def test_parse_addtask_deltask(self):
> -        import sys
>=20
> -        with self.assertLogs() as logs:
> -            f =3D self.parsehelper(self.addtask_deltask)
> -            d =3D bb.parse.handle(f.name, self.d)['']
> +        f =3D self.parsehelper(self.addtask_deltask)
> +        d =3D bb.parse.handle(f.name, self.d)['']
>=20
> -        output =3D "".join(logs.output)
> -        self.assertTrue("addtask contained multiple 'before' keywords" i=
n output)
> -        self.assertTrue("addtask contained multiple 'after' keywords" in=
 output)
> -        self.assertTrue('addtask ignored: " do_patch"' in output)
> -        self.assertEqual(['do_myplaintask', 'do_mytask', 'do_mytask2'], =
d.getVar("__BBTASKS"))
> -        #self.assertTrue('dependent task do_foo for do_patch does not ex=
ist' in output)
> +        self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'd=
o_mytask', 'do_mytask2'], d.getVar("__BBTASKS"))
>=20
>      broken_multiline_comment =3D """
>  # First line of comment \\

//Peter


