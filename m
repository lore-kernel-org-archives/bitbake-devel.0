Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6182BC77B6C
	for <webhook@archiver.kernel.org>; Fri,  7 Apr 2023 03:07:38 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.70.1680836849232696229
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 20:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=J72a1f4s;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3461ef5591=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3372iTZj004635
	for <bitbake-devel@lists.openembedded.org>; Thu, 6 Apr 2023 20:07:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=sJlbIir+dgUCJS3A7QC3N1oMGwsBMT48YvNL3LIquwU=;
 b=J72a1f4sjhyBLb2wGbzczdNUJYC+SGfyQS4YoAvzEfJn/1zmLnmLTBO5wrYXzJsqxIkG
 JN6aMbkH5kgzXkrl2vJoKOoJ9M6mxlfvHRPd8+wPxhx+X1Du11fTAoUUtXZ1ZH6CN3LK
 gzPK3DaNuaxX7NLFGovdkAB0cNtg5/JUpGlw4176zx0Znjc4tJBohPBlNn5mWcxAmEfH
 o1LPVbyu/rJZq7r80YZsxU2Qb24ZkE/2RI2lkcxuYACpb+dYagT++8+paUTQWv/Ie1Cr
 TIoPc48HuRxzJ2/8BCbTDpKMgMHMCs0/1FJap2a5Hb32zpqWxz5j7wGl5NOZIYRghFo4 dQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ppfw6xdaf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 20:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaAk0o1T1ISOxuiG5uJQltyvm6XoO4GcUBQ5VkibouQoJgE32Ux62dlntlxxBoHtXXJlaHnrIfWAAxRporTJbCJAjZ7CNmaHop8bsPvUNhp0rL8q3B/YEU+sdCBuP9aVJsvMlUWQnH3M+rbixgDBlHcQzaGUR+nrvio0YCe7Aq2m47dB227VfDsxSzNKKD6jDHw4lMt13FQXpMm/b7Ntjrxu48+jgCQVcXCaP1AqAeTySiX+gOEQI3POuQcO2dReMIu0IxN1zyPOYVB6AWojUQ2HofgKMIQM7P83nzuXh4k85sBy/IoN/Bi+fbo5JBKgMqXbFXFNEQhc4pGGN7Uesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJlbIir+dgUCJS3A7QC3N1oMGwsBMT48YvNL3LIquwU=;
 b=L9UTub1iBVnmtrWjYK7Uz6yRh2sgpyqVnf5KD32YQ1S1TwCc4tKzhhOqA1vcTn0JMQiVOwBsF6i+MsRZtMcgcHD9Wb6wIJgd/JtBBy3/YVeB28AP6TcAkIoucvkeafHp9dEiR9vJJDM/rOJdHTOfxtRxvP9Xiss2vVrL9XUpP/igcG4FARGPY/oi6v1SR3W3dBZiP1jN6GpAhTFayZ5xVKibox8r7vPjHs119NYUzO9A5zDPF9/e+CuA/mnl860nzVNnOUxfFqFcbqhfphp9HUppSsnWPJbbAc0dsLkhasx+PQDQ0ghkjNxqmnNoJuTgxDF17MFqk7NAY+HZIxCfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 03:07:27 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::ab37:4985:7b95:2b95]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::ab37:4985:7b95:2b95%6]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 03:07:26 +0000
From: Chen Qi <Qi.Chen@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 2/2] runqueue.py: use 'full' line for PSI check
Date: Thu,  6 Apr 2023 20:07:15 -0700
Message-Id: <20230407030715.4394-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407030715.4394-1-Qi.Chen@windriver.com>
References: <20230407030715.4394-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS0PR11MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 26da423c-805d-40e8-25c8-08db3715370a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pgHuZXWSLrVfNdujIuwrO0hGdhOmudTKPA3psgjWXtH3qV4QkmJUQJeYEir3UHP6mZHgfbTjsGHVytXcKO1Kqjx58mBly/2Tk4QBAygBP2kHGE7qmoJTb61EBYXyMrgY+3AZu62G69emVNcjxRaoJlwhJj2iNMBFxtl55ZFBYTBFPj3o6j9gBVDaf5m3U4CksVUXFWHtBGoTS4fwvdGYEJdLcGaVO2PuFcVqHrSVFXVhGYEesXDcZ1o1ILTAkkprXow1hxrKOUiI1ypPjSED5LY4vKHNLFJN6SH9te18AUlVwlwyVOO69hqWBI7LKiccwgDAFxxmw10coR7i7L6EoCgUe20JlKbDzWoxt8M7r1u0N3Q5skxR6fGbMFIEcOwbUnkX3yAQ8BjV63rb0VpXbRk954EisQCdlEh+cqMdFVkC6A1b043DD7i0ARkdbX6JPTuYtoUL8Sx+ULn31xTlLp+oUYAULc8oElD0q8V2Bx1NPn3kCHRADMVoji7Wb9HFfzBKddXavFVk0Aknx3BoQTdDvsLxUK+CWsf1yBf3rLTi1zXWokeBQ0HX3sK8huD9SmVx+EDiwxxlKVJsXfW32N9o/IdrN1zNBXXB1dVumcg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(451199021)(2906002)(86362001)(36756003)(966005)(2616005)(186003)(6486002)(6512007)(52116002)(1076003)(6506007)(83380400001)(26005)(6666004)(316002)(66946007)(38100700002)(66556008)(478600001)(66476007)(6916009)(8676002)(41300700001)(5660300002)(38350700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDBYeTZDaURJeVRhUXZvY3pYL25YOTJXeWc1RU4xcUZTYndmbUdHY0lHdWNz?=
 =?utf-8?B?bE1MSkZibzZEcEgxalRzTGdSeGl3Y2xxZnpwWFNKdXUrR2hLOEZ1VEVIOVor?=
 =?utf-8?B?VDF5WFlxbmtURk94VVVTcHJJcW1uV3RSWGRvcjlnTWtjMUg4R09Wb2tCcHBa?=
 =?utf-8?B?VGhDcWs1TXJTWlkzS2oxSmJhN05oOVE3L1JZZXNMM3QrSkJwN3R4YmdrRDN5?=
 =?utf-8?B?a29pQTlvOFE1V25EdDhHdlJUcndyd3NzQ01EZmhJdVRHYk95WWhrdWxrYzJO?=
 =?utf-8?B?SlJmRmZCRy9EcFAwd0xhQmE5Q05FUXRsWSt5N2l3NGR2eW8yd09XL2pBT2E4?=
 =?utf-8?B?Zy9Jd0tnOC8vVmlVODdsS3lmdFZHanRNMjYxalNuSFdUMHdkWkhvUHBKbFJp?=
 =?utf-8?B?UlRXOE5BbWpaQ0FhN2dzR2FIek1POW1NWnVCSmxqZ1Qyeis3c0VVVUVJWGk0?=
 =?utf-8?B?cTdsNzZ5cGRvL1pHN1JnbW5BSGFsdXE4Q3psQ1BoOXF3Z25kdVZCZjVPQ20z?=
 =?utf-8?B?cFExM3VuNmhJN2ZyZCsxVjJXRFJETlM3TGR1NFpkbzNiUEJhQk1jOFJkOERY?=
 =?utf-8?B?aHNjN2laVUJUcDA2MDFmRjRkOGhQMEZhbU8rZ0RNRnVWNXo1M3FzMlZ1bUNL?=
 =?utf-8?B?K0Q1WkIzM3FiKzZlY0JwQ1h6QXd6a3hzcGNPK2w3eFZ0b1hjd2NXVFE2N2pU?=
 =?utf-8?B?WGVPMDJIYXBhWHRmVzRIUTAwdWxzNU0wcXZSNkFpc1pHdDV0YWNjOVljd0dH?=
 =?utf-8?B?eGx1WVYvM3FEMmFqMjE2MGpONlFqazY0SldoTEo5MjlvbWh2ZHVwWjdyRDNo?=
 =?utf-8?B?R2ZKOWtyY0pPc1BQMkZQL2lnaldDYlNzdWRXWHM2YVU5WStVODdPTy9rQXNJ?=
 =?utf-8?B?MW9PU2ZiQllhbXEwcjlTbk5jZXBHTGV0Uk96MXZISDVHa3hlVTIwQ1VvOFRi?=
 =?utf-8?B?dFFFQ21nbU8zWHg0V3FQaWRxNVcxT1poRUoxZkhSenVCWTZ1VXdIVzlEUUJS?=
 =?utf-8?B?TW9yZEd6amx2THIzVnphNXRkdUNUSTNZTjcvSUdIRDhPanFPaFZveG1YOS93?=
 =?utf-8?B?MkUxVk8wN0tnWXBPK0dMTjZad2FVR3dnWWtuL0U5SlBaSmtkZjlJSlNYeFhl?=
 =?utf-8?B?ZnhUT1pmOGxsL29wc0l5R2ZONTZpeTBJSXkwVGRuV0pOSWZtY0ZIVW0ybFlP?=
 =?utf-8?B?SnFOK25nVTNuZ1c1TGFwWG1tbnFIWWpYNUxZYzNZTHF2eVVWc3R4RHYrM0pT?=
 =?utf-8?B?bTFBQnFWUG12QUcvRkJxeG1rVVNpWWVaODAvemNIRDJ1M2dlWUdXei9KTVI2?=
 =?utf-8?B?Skh5b0dYTWxQUXlaM05OR3E1ZlVBZWFkRXNCM0ZBNExXVjZLRS9NUzJSenZk?=
 =?utf-8?B?NTlUSUlRNDREcGcvSms0cytUUUo4dVhPQ29IKzVXRGxvY3FJb1ZMby9oKzVx?=
 =?utf-8?B?eVhWZzl1S2hXc3FyNGJjREplY3NqUGZGR3FpeXFtNDFKSTdJWFJYRzZMUThp?=
 =?utf-8?B?RnZ6Y0w2Vm9uZElrMG81V1R0TEgxblNBVExtSXRaUEh2bVplWmdjMnRVdVRB?=
 =?utf-8?B?WG81c0Uwbm9wMmFobjZ0MGJabWFrMWFLMit4UTQzMWpGT2IvbnR4cGl1MUFE?=
 =?utf-8?B?MDNYcURjY0M0OVRQM2t2R0tWMUJpcDVoOEFUNlVNSnpPaXZZNVp6MUJTNU5v?=
 =?utf-8?B?aDcxQmh2ZDJWZXZJZmdvc2locTlhcjk4bGFTTmNraUNPUDRWb0dMa2h2bHJM?=
 =?utf-8?B?dytMeStMRU9rc1VzWWZjeVYrWXkyai9jTVFuZCtEZDVCU1BBd05JUlZpRWhl?=
 =?utf-8?B?WlZPSFFBaHdJRXVPcDFOeDFCK25EdXhJOHVFeHdSM2kvVW1lYUl0eDRGMzhj?=
 =?utf-8?B?NmxuOVRyMDdMT2JBVnYrdldVQW9qWnkxWnJXZ1UwT0IwdTYxbG1rYXVOMlBM?=
 =?utf-8?B?RmhvUDcrbkF2aGQ3ekF4UmNFSTEvZzhSTjJSOVA3aXY3RnBjRXhUNHRuaDg0?=
 =?utf-8?B?a1hwSUc4WjRmSko4TUFxL3lsMkV6dGJ3NWZoUXZ3WnZKQTRPb3R2S1BaazIr?=
 =?utf-8?B?WmF1OWthWFFUelJVQVFzODNSUkJad3lrL2RBeVhhRm9pNG1WVmppRmlNRW9k?=
 =?utf-8?B?cTgvOHl4Y3dFWjAvRzJKcHorOWtKMlc4bTNvbC9PZ2lia1M5THc4TzVsUWZQ?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26da423c-805d-40e8-25c8-08db3715370a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 03:07:26.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MmNL8hFOCHmtAthRsWewSeR4nYqHtAtluwLUwEcNB8wap1kq9fx41p2DshmH0+aEQVlPbA8sEyjE/jlkzIO2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-Proofpoint-ORIG-GUID: orLjEQ2xt-9NrVQfDYClZ4gYRKG5SghD
X-Proofpoint-GUID: orLjEQ2xt-9NrVQfDYClZ4gYRKG5SghD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=483 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070028
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 3372iTZj004635
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 03:07:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14683

According to kernel PSI doc[1], for /proc/pressure/* interface files,
the first line is the 'some' line and the second line is the 'full'
line.

Quoting from the doc:
"""
The "some" line indicates the share of time in which at least some tasks
are stalled on a given resource.

The "full" line indicates the share of time in which all non-idle tasks
are stalled on a given resource simultaneously. In this state actual CPU
cycles are going to waste, and a workload that spends extended time in th=
is
state is considered to be thrashing. This has severe impact on performanc=
e,
and it=E2=80=99s useful to distinguish this situation from a state where =
some tasks
are stalled but the CPU is still doing productive work.
"""

We can see that the 'full' line is a better measurement to check if thing=
s are
slowed down as a whole.

Also, the /proc/pressure/cpu's 'full' line may not be available on some s=
ystems,
so fall back to the 'some' line.

[1] https://www.kernel.org/doc/html/latest/accounting/psi.html

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 02f1474540..e3198dcdeb 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -173,10 +173,13 @@ class RunQueueScheduler(object):
                 with open("/proc/pressure/cpu") as cpu_pressure_fds, \
                     open("/proc/pressure/io") as io_pressure_fds, \
                     open("/proc/pressure/memory") as memory_pressure_fds=
:
-
-                    self.prev_cpu_pressure =3D cpu_pressure_fds.readline=
().split()[4].split("=3D")[1]
-                    self.prev_io_pressure =3D io_pressure_fds.readline()=
.split()[4].split("=3D")[1]
-                    self.prev_memory_pressure =3D memory_pressure_fds.re=
adline().split()[4].split("=3D")[1]
+                    cpu_lines =3D cpu_pressure_fds.readlines()
+                    if len(cpu_lines) =3D=3D 1:
+                        self.prev_cpu_pressure =3D cpu_lines[0].split()[=
4].split("=3D")[1]
+                    else:
+                        self.prev_cpu_pressure =3D cpu_lines[1].split()[=
4].split("=3D")[1]
+                    self.prev_io_pressure =3D io_pressure_fds.readlines(=
)[1].split()[4].split("=3D")[1]
+                    self.prev_memory_pressure =3D memory_pressure_fds.re=
adlines()[1].split()[4].split("=3D")[1]
                     self.prev_pressure_time =3D time.time()
                 self.check_pressure =3D True
             except:
@@ -194,10 +197,14 @@ class RunQueueScheduler(object):
             with open("/proc/pressure/cpu") as cpu_pressure_fds, \
                 open("/proc/pressure/io") as io_pressure_fds, \
                 open("/proc/pressure/memory") as memory_pressure_fds:
-                # extract "total" from /proc/pressure/{cpu|io}
-                curr_cpu_pressure =3D cpu_pressure_fds.readline().split(=
)[4].split("=3D")[1]
-                curr_io_pressure =3D io_pressure_fds.readline().split()[=
4].split("=3D")[1]
-                curr_memory_pressure =3D memory_pressure_fds.readline().=
split()[4].split("=3D")[1]
+                # extract "total" from /proc/pressure/{cpu|io|memory}
+                cpu_lines =3D cpu_pressure_fds.readlines()
+                if len(cpu_lines) =3D=3D 1:
+                    curr_cpu_pressure =3D cpu_lines[0].split()[4].split(=
"=3D")[1]
+                else:
+                    curr_cpu_pressure =3D cpu_lines[1].split()[4].split(=
"=3D")[1]
+                curr_io_pressure =3D io_pressure_fds.readlines()[1].spli=
t()[4].split("=3D")[1]
+                curr_memory_pressure =3D memory_pressure_fds.readlines()=
[1].split()[4].split("=3D")[1]
                 now =3D time.time()
                 tdiff =3D now - self.prev_pressure_time
                 if tdiff > 1.0:
--=20
2.37.1


