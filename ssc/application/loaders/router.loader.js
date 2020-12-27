const userRouter = require('../api/users/routes');
const loadRouter = (app)=>{

    app.use('/user', userRouter);

    app.use((req,res,next)=>{
        res.status(404).json({success: false,message: "Not Found"});
    });
};

module.exports = loadRouter;