const {createEmail, authEmail, saveHolder, saveStudentIdCard} = require("../services");

const userController ={
    EmailService: async (req,res,next)=>{
        const {email} = req.body;
        const result = await createEmail({email});
        console.log(result);
        const ret = await authEmail(result);
        res.status(201).json({success: true, result: ret});
    },
    registerService: async (req,res,next)=>{
        const {name, studentId, university, department} = req.body;
        console.log('학생의 정보');
        console.log(name, studentId, university, department);
        const holderId = await saveHolder({name, studentId, university, department});
        console.log('holderId'+holderId);
        const result = await saveStudentIdCard(holderId);
        res.status(201).json({success: 'success', HolderId: result});
        
    }
}

module.exports = userController;